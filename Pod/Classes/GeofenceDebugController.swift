//
//  GeofenceDebugController.swift
//  GeofenceDebugController
//
//  Created by Ryosuke Hiramatsu on 2016/02/17.
//  Copyright © 2016年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit
import CoreLocation

public class GeofenceDebugController: UITableViewController {

    private let locationManager = CLLocationManager()
    private var allRegions = [CLRegion]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        for region in locationManager.monitoredRegions {
            allRegions.append(region)
        }

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(GeofenceDebugController.reload), forControlEvents: UIControlEvents.ValueChanged)
        tableView.alwaysBounceVertical = true
    }
    
    @IBAction private func mapButtonTouched() {
        performSegueWithIdentifier("showMap", sender: nil)
    }
    
    @IBAction private func closeButtonTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func reload() {
        allRegions = []
        for region in locationManager.monitoredRegions {
            allRegions.append(region)
        }
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRegions.count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "GeofenceDebugControllerCell")
        if let circularRegion = allRegions[indexPath.row].copy() as? CLCircularRegion {
            cell.textLabel?.text = circularRegion.identifier
            cell.detailTextLabel?.text = "\(circularRegion.center.latitude), \(circularRegion.center.longitude)"
        }
        
        return cell
    }
    
    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("showMap", sender: allRegions[indexPath.row])
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            if let destVC = sender?.destinationViewController as? GeofenceDebugMapController {
                destVC.firstCenterRegion = sender as? CLCircularRegion
            }
        }
    }
}

extension GeofenceDebugController {
    class public func show(rootViewController: UIViewController) {
        if let bundleURL = NSBundle(forClass: self).URLForResource("GeofenceDebugController",  withExtension: "bundle") {
            let bundle = NSBundle(URL: bundleURL)
            let storyboard = UIStoryboard(name: "GeofenceDebugController", bundle: bundle)
            if let geofenceDebugController = storyboard.instantiateInitialViewController() {
                rootViewController.presentViewController(geofenceDebugController, animated: true, completion: nil)
            }
        }
        
        
    }
}
