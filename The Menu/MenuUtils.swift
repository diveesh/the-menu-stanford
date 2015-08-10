//
//  MenuUtils.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import Foundation

class Utils {
    class func getTime(mealNum : NSNumber) -> String {
        switch mealNum {
        case 0:
            return "Lunch"
        case 1:
            return "Dinner"
        default:
            return ""
        }
    }
    
    class func getDay(dayNum : NSNumber) -> String {
        switch dayNum {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return ""
        }
    }
}