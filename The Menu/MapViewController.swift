//
//  MapViewController.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .Hybrid
            mapView.delegate = self
            handleWaypoint()
        }
    }
    
    var waypoint: Waypoint?
    
    private func handleWaypoint() {
        var annotations = [MKAnnotation]()
        annotations.append(waypoint!)
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
