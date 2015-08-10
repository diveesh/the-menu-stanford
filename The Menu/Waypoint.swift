//
//  Waypoint.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import Foundation
import MapKit

class Waypoint: NSObject, MKAnnotation {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
