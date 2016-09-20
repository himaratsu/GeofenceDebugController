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
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

// MARK: - IBAction
extension ViewController {
    @IBAction private func tokyoTowerButtonTouched(sender: AnyObject) {
        let center = CLLocationCoordinate2DMake(35.681382, 139.766084)
        let region = CLCircularRegion(center: center, radius: 200, identifier: "Tokyo Tower")
        locationManager.startMonitoringForRegion(region)
        showAlert("New geofence added", message: "Tokyo Tower")
    }
    
    @IBAction private func roppongiHillsTouched(sender: AnyObject) {
        let center = CLLocationCoordinate2DMake(35.660428, 139.729182)
        let region = CLCircularRegion(center: center, radius: 200, identifier: "Roppongi Hills")
        locationManager.startMonitoringForRegion(region)
        
        showAlert("New geofence added", message: "Roppongi Hills")
    }
    
    @IBAction private func asakusaButtonTouched(sender: AnyObject) {
        let center = CLLocationCoordinate2DMake(35.711877, 139.796697)
        let region = CLCircularRegion(center: center, radius: 200, identifier: "Asakusa")
        locationManager.startMonitoringForRegion(region)
        
        showAlert("New geofence added", message: "Asakusa")
    }
    
    @IBAction private func debugButtonTouched(sender: AnyObject) {
        GeofenceDebugController.show(self)
    }
}
