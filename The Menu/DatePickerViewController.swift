//
//  DatePickerViewController.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/12/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate : class {
    func scheduleNotification(notificationDate: NSDate)
    func setButtonToDisabled()
}
/*
 * Taken from Apple example on how to use DatePicker class
 */
class DatePickerViewController: UIViewController {
    
    var meal: Meal?
    
    var delegate: DatePickerViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "light-blue-background")!)
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "doneButtonPressed")
        self.navigationItem.rightBarButtonItem = doneButton
        
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "cancelButtonPressed")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        configureDatePicker()
    }
    
    func cancelButtonPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneButtonPressed() {
        delegate?.setButtonToDisabled()
        delegate?.scheduleNotification(datePicker.date)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Configuration
    
    func configureDatePicker() {
        datePicker.datePickerMode = .DateAndTime
        datePicker.timeZone = NSTimeZone.localTimeZone()

        let now = NSDate()
        datePicker.minimumDate = now
        
        let currentCalendar = NSCalendar.currentCalendar()
        
        let dateComponents = NSDateComponents()
        dateComponents.day = 7
        
        let sevenDaysFromNow = currentCalendar.dateByAddingComponents(dateComponents, toDate: now, options: nil)
        datePicker.maximumDate = sevenDaysFromNow
        
        datePicker.minuteInterval = 1
    }
    



}
