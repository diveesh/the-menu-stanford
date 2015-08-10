//
//  MenuDatabase.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/5/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class MenuDatabase {
    class var sharedInstance: MenuDatabase {
        struct Static {
            static var instance: MenuDatabase?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MenuDatabase()
        }
        return Static.instance!
    }
    
    //Taken from StackOverflow
    func removeObject<T : Equatable>(object: T, inout fromArray array: [T])
    {
        var index = find(array, object)
        array.removeAtIndex(index!)
    }
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    private var places: [Place]?
    
    private var selectedMeals = [Meal]()
    
    private var mealsToNotification = Dictionary<Meal, UILocalNotification>()
    
    func getPlaces() -> [Place]? {
        if places == nil {
            let fetchRequest = NSFetchRequest(entityName: "Place")
            if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Place] {
                places = fetchResults
            }
        }
        return places
    }
    
    func addNotification(meal: Meal, notification: UILocalNotification) {
        mealsToNotification[meal] = notification
    }
    
    func getNotificationFromMeal(meal: Meal) -> UILocalNotification? {
        return mealsToNotification[meal]?
    }
    
    func addSelectedMeal(meal: Meal) {
        if !contains(selectedMeals, meal) {
            selectedMeals.append(meal)
        }
    }
    
    func removeSelectedMeal(index: Int) {
        selectedMeals.removeAtIndex(index)
    }
    
    func getSelectedMeals() -> [Meal] {
        return selectedMeals
    }
    
    func getMeals(fromPlace : Place) -> NSSet {
        return fromPlace.toMeals
    }
    

}
