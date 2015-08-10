//
//  The_Menu.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/5/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import Foundation
import CoreData

class Place: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var imageName: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var toMeals: NSSet

}
