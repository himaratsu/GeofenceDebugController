//
//  ViewController.swift
//  GeofenceDebugController
//
//  Created by Ryosuke Hiramatsu on 03/22/2016.
//  Copyright (c) 2016 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit
import CoreLocation
import GeofenceDebugController

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    private func requestAuthorization() {
        
    }
    
    @IBAction private func addGeofenceButtonTouched(sender: AnyObject) {
        // Tokyo Tower
        let center = CLLocationCoordinate2DMake(35.681382, 139.766084)
        let region = CLCircularRegion(center: center, radius: 200, identifier: "Tokyo Tower")
        locationManager.startMonitoringForRegion(region)
        
        showAlert("New geofence added")
    }
    
    @IBAction private func debugButtonTouched(sender: AnyObject) {
        GeofenceDebugController.show(self)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}