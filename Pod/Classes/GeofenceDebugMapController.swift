//
//  GeofenceDebugMapController.swift
//  GeofenceDebugController
//
//  Created by Ryosuke Hiramatsu on 2016/02/17.
//  Copyright © 2016年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit
import MapKit

class GeofenceDebugMapController: UIViewController, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var firstCenterRegion: CLCircularRegion?
    
    @IBOutlet weak private var mapView: MKMapView!
    private var currentLocation: CLLocationCoordinate2D?
    @IBOutlet weak var currentButton: UIButton! {
        didSet {
            currentButton.layer.cornerRadius = 22
            currentButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        startStandardUpdates()
        
        for region in locationManager.monitoredRegions {
            if let circularRegion = region.copy() as? CLCircularRegion {
                addPin(circularRegion.identifier, center: circularRegion.center)
                addTemporaryCircle(circularRegion.center, radius: circularRegion.radius)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let firstCenterRegion = firstCenterRegion {
            setMapCenter(firstCenterRegion.center, animated: true)
        } else {
            if let firstRegion = locationManager.monitoredRegions.first {
                if let circularRegion = firstRegion.copy() as? CLCircularRegion {
                    setMapCenter(circularRegion.center, animated: true)
                }
            }
        }
    }
    
    private func addPin(identifier: String, center: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = identifier
        mapView.addAnnotation(annotation)
    }
    
    private func addTemporaryCircle(center: CLLocationCoordinate2D, radius: Double) {
        let circle = MKCircle(centerCoordinate: center, radius: radius)
        mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.fillColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.1)
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    private func startStandardUpdates() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func setMapCenter(coordinate: CLLocationCoordinate2D, animated: Bool) {
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: animated)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView?.animatesDrop = true
        } else {
            pinView?.annotation = annotation
        }
        pinView?.canShowCallout = true
        
        return pinView
    }

    @IBAction private func currentLocationButtonTouched(sender: AnyObject) {
        if let currentLocation = currentLocation {
            setMapCenter(currentLocation, animated: false)
        } else {
            showRequestLocationAlert()
        }
    }
    
    private func showRequestLocationAlert() {
        let alertController = UIAlertController(title: "Location Service OFF",
            message: "Please allow to access Location Service at Settings",
            preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Settings",
            style: .Default,
            handler: { (_) -> Void in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // MARL: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            // 現在地がまだ読み込まれてない、読み込めない場合は何もしない
            return
        }
        currentLocation = location.coordinate
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}
