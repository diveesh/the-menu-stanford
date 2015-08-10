//
//  The_Menu.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import Foundation
import CoreData

class Meal: NSManagedObject {

    @NSManaged var day: NSNumber
    @NSManaged var food: String
    @NSManaged var time: NSNumber
    @NSManaged var toPlace: The_Menu.Place

}
