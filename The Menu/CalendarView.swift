//
//  CalendarView.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit

protocol CalendarViewDataSource: class {
    func getMeal(fromDay: Int, fromTime: Int) -> Meal
    func getSelectedMeals() -> [Meal]
}

protocol CalendarViewDelegate: class {
    func mealSelected(mealNum: Int)
    func segueToDatePickerViewController(buttonTag: Int)
}

class CalendarView: UIView {
    
    var dataSource: CalendarViewDataSource?
    
    var delegate: CalendarViewDelegate?
    

    override func drawRect(rect: CGRect) {
        if self.traitCollection.verticalSizeClass == .Compact {
            drawVerticalLines(Constants.NumDays)
            drawHorizontalLines(Constants.NumMeals)
            fillMealsHorizontal()
        } else if self.traitCollection.verticalSizeClass == .Regular {
            drawVerticalLines(Constants.NumMeals)
            drawHorizontalLines(Constants.NumDays)
            fillMealsVertical()
        }
        
    }
    
    private func fillMealsHorizontal() {
        let width = bounds.size.width / CGFloat(Constants.NumDays)
        let height = bounds.size.height / CGFloat(Constants.NumMeals) / CGFloat(Constants.LabelsPerCell)
        for (var i = 0; i < Constants.NumMeals; i++) {
            for (var j = 0; j < Constants.NumDays; j++) {
                let meal = dataSource?.getMeal(j, fromTime: i)
                let dayX = width * CGFloat(j)
                let dayY = height * CGFloat(Constants.LabelsPerCell) * CGFloat(i)
                createLabel(dayX, y: dayY, width: width, height: height, text: Utils.getDay(j), fontSize: 12)
                let timeX = dayX
                let timeY = dayY + height
                createLabel(timeX, y: timeY, width: width, height: height, text: Utils.getTime(i), fontSize: 12)
                let itemX = dayX
                let itemY = timeY + height
                createLabel(itemX, y: itemY, width: width, height: height, text: meal!.food, fontSize: 12)
                
                let buttonX = itemX + CGFloat(Constants.ButtonSideSpacing)
                let buttonY = itemY + height
                if (!contains(dataSource!.getSelectedMeals(), dataSource!.getMeal(j, fromTime: i))) {
                    createButton(buttonX, y: buttonY, width: (width - CGFloat(2 * Constants.ButtonSideSpacing)), height: (height - CGFloat(2 * Constants.ButtonVertSpacing)), text: Constants.AddReminderText, day: j, time: i, color: UIColor.greenColor(), enabled: true)
                } else {
                    createButton(buttonX, y: buttonY, width: (width - CGFloat(2 * Constants.ButtonSideSpacing)), height: (height - CGFloat(2 * Constants.ButtonVertSpacing)), text: Constants.ReminderSetText, day: j, time: i, color: UIColor.grayColor(), enabled: false)
                }

                
            }
        }
    }
    
    private func fillMealsVertical() {
        let width = bounds.size.width / CGFloat(Constants.NumMeals)
        let height = bounds.size.height / CGFloat(Constants.NumDays) / CGFloat(Constants.LabelsPerCell)
        for (var i = 0; i < Constants.NumDays; i++) {
            for (var j = 0; j < Constants.NumMeals; j++) {
                let meal = dataSource?.getMeal(i, fromTime: j)
                let dayX = width * CGFloat(j)
                let dayY = height * CGFloat(Constants.LabelsPerCell) * CGFloat(i)
                createLabel(dayX, y: dayY, width: width, height: height, text: Utils.getDay(i), fontSize: 12)
                
                let timeX = dayX
                let timeY = dayY + height
                createLabel(timeX, y: timeY, width: width, height: height, text: Utils.getTime(j), fontSize: 12)
                
                let itemX = dayX
                let itemY = timeY + height
                createLabel(itemX, y: itemY, width: width, height: height, text: meal!.food, fontSize: 12)
                
                let buttonX = itemX + CGFloat(Constants.ButtonSideSpacing)
                let buttonY = itemY + height
                if (!contains(dataSource!.getSelectedMeals(), dataSource!.getMeal(i, fromTime: j))) {
                    createButton(buttonX, y: buttonY, width: (width - CGFloat(2 * Constants.ButtonSideSpacing)), height: (height - CGFloat(2 * Constants.ButtonVertSpacing)), text: Constants.AddReminderText, day: i, time: j, color: UIColor.greenColor(), enabled: true)
                } else {
                    createButton(buttonX, y: buttonY, width: (width - CGFloat(2 * Constants.ButtonSideSpacing)), height: (height - CGFloat(2 * Constants.ButtonVertSpacing)), text: Constants.ReminderSetText, day: i, time: j, color: UIColor.grayColor(), enabled: false)
                }
            }
        }
    }
    
    private func createLabel(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, fontSize: Int) {
        var label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.text = text
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: CGFloat(fontSize))
        label.numberOfLines = 0
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    private func createButton(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, day: Int, time: Int, color: UIColor, enabled: Bool) {
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.backgroundColor = color
        button.setTitle(text, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.titleLabel!.font = UIFont(name: button.titleLabel!.font.fontName, size: CGFloat(Constants.ButtonFontSize))
        button.tag = day * 2 + time
        button.enabled = enabled
        self.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        delegate!.segueToDatePickerViewController(sender.tag)
    }
    
    func setButtonAsCanceled(sender: UIButton) {
        delegate?.mealSelected(sender.tag)
        sender.backgroundColor = UIColor.grayColor()
        sender.enabled = false
        sender.setTitle(Constants.ReminderSetText, forState: UIControlState.Disabled)
    }

    
    private func drawVerticalLines(numLines : Int) {
        var myBezier = UIBezierPath()
        myBezier.moveToPoint(CGPoint(x: 0, y: 0))
        var currX: CGFloat = 0
        for (var i = 0; i < numLines; i++) {
            myBezier.addLineToPoint(CGPoint(x: currX, y: bounds.height))
            var newX = currX + (bounds.width / CGFloat(numLines))
            myBezier.moveToPoint(CGPoint(x: newX, y: 0))
            currX = newX
        }
        UIColor.whiteColor().setStroke()
        myBezier.stroke()
    }
    
    private func drawHorizontalLines(numLines : Int) {
        var myBezier = UIBezierPath()
        myBezier.moveToPoint(CGPoint(x: 0, y: 0))
        var currY: CGFloat = 0
        for (var i = 0; i < numLines; i++) {
            myBezier.addLineToPoint(CGPoint(x: bounds.width, y: currY))
            var newY = currY + (bounds.height / CGFloat(numLines))
            myBezier.moveToPoint(CGPoint(x: 0, y: newY))
            currY = newY
        }
        UIColor.whiteColor().setStroke()
        myBezier.stroke()
    }
    
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        for subview in self.subviews as [UIView] {
            subview.removeFromSuperview()
        }
        setNeedsDisplay()
    }
    
    struct Constants {
        static let NumDays = 7
        static let NumMeals = 2
        static let LabelsPerCell = 4
        static let AddReminderText = "Remind me!"
        static let ReminderSetText = "Will remind"
        static let ButtonSideSpacing = 10
        static let ButtonVertSpacing = 5
        static let ButtonFontSize = 10
    }

}
