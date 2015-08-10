//
//  CalendarViewController.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit
import CoreData

class CalendarViewController: UIViewController, CalendarViewDataSource, CalendarViewDelegate, DatePickerViewControllerDelegate {

    var meals: [Meal]?
    
    var toSchedule: Int?
    
    var menuDatabase = MenuDatabase.sharedInstance
    
    override func viewDidAppear(animated: Bool) {
        calendarView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        calendarView.backgroundColor = UIColor(patternImage: UIImage(named: "darkbluebackground")!)
    }
    
    func setButtonToDisabled() {
        calendarView.setButtonAsCanceled(calendarView.viewWithTag(toSchedule!) as UIButton)
    }
    
    func scheduleNotification(notificationDate: NSDate) {
        var localNotification = UILocalNotification()
        localNotification.alertAction = "Launch"
        var alertString = "Remember, \(meals![toSchedule!].toPlace.name) is serving \(meals![toSchedule!].food) for \(Utils.getTime(meals![toSchedule!].time)) on \(Utils.getDay(meals![toSchedule!].day))"
        localNotification.alertBody = alertString
        localNotification.fireDate = notificationDate
        localNotification.timeZone = NSTimeZone.localTimeZone()
        menuDatabase.addNotification(meals![toSchedule!], notification: localNotification)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    

    @IBOutlet weak var calendarView: CalendarView! {
        didSet {
            calendarView.dataSource = self
            calendarView.delegate = self
        }
    }
    
    func getMeal(fromDay: Int, fromTime: Int) -> Meal {
        return meals![fromDay * 2 + fromTime]
    }
    
    func mealSelected(mealNum: Int) {
        menuDatabase.addSelectedMeal(meals![mealNum])
    }
    
    func getSelectedMeals() -> [Meal] {
        return menuDatabase.getSelectedMeals()
    }
    
    func segueToDatePickerViewController(buttonTag: Int) {
        toSchedule = buttonTag
        performSegueWithIdentifier("fromCalendarToDatePicker", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let dpvc = nvc.topViewController as? DatePickerViewController {
                dpvc.delegate = self
                dpvc.meal = meals![toSchedule!]
            }
            
        }
    }

}
