//
// File   : LocationViewController.swift
// Author : Isaac Qiao, Charles Li
// Date created: Nov.18 2015
// Date edited : Nov.23 2015
// Description: This is class is responsible for loading the group data and displaying in 
//              a table view and on a map at the same time 
//
// Created by IsaacQ on 2015-11-18.
// Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//This protocol is used as a delegate to pass data back from 
//GroupTableViewControllerto LocationViewController
protocol GroupLoadingProtocol
{
  func didFinishLoading(groups:[Group])
}


class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,GroupLoadingProtocol
{
  
  //MARK:Properties
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var groupsContainer: UIView!
  
  var category = "MyGroups"
  let locationManager =  CLLocationManager()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    NSLog("viewDidLoad")
    self.locationManager.delegate = self
    
    self.locationManager.requestWhenInUseAuthorization()
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    self.locationManager.startUpdatingLocation()
    
    self.mapView.showsUserLocation = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  ////////////////////
  //Delegate Methods//
  ////////////////////
  
  
  //This delegate method is called in GroupTableViewController and
  //loads the data to the map when the group table view controller 
  //finishes loading the data 
  func didFinishLoading(groups:[Group])
  {
    for group in groups
    {
      let newGroup = group
      
      // here write the things about pins
      let groupwork = newGroup
      
      // map view
      var groupLocation =  (groupwork.address)! + ","
      groupLocation += (groupwork.city)!    + ","
      groupLocation += (groupwork.province)!
      NSLog(groupLocation)
      let geocoder = CLGeocoder()
      
      geocoder.geocodeAddressString(groupLocation, completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
        
        if let firstPlacemark = placemarks?[0] {
          let location = firstPlacemark.location!
          let center = CLLocationCoordinate2DMake (location.coordinate.latitude, location.coordinate.longitude)
          
          let annotation = MKPointAnnotation()
          annotation.coordinate = center
          annotation.title = (groupwork.name)!
          annotation.subtitle = (groupwork.sport)!
          self.mapView.addAnnotation(annotation)
        }
      })
    }
  } 
  
  
  //The following two methods are delegate methods for setting up the location manager and map view
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location = locations.last
    
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    self.mapView.setRegion(region, animated: true)
    
    self.locationManager.stopUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
  {
    print("Error: " + error.localizedDescription)
  }
  
  //This notifies the embedded segue which data category the table should retrieve 
  //and sets up the delegateObject variable  in GropTableViewController to LocationViewController 
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "showGroupTable") 
    {
      let GroupTableVC = segue.destinationViewController as! GroupTableViewController
      
      //pass category data to GroupTableViewController
      GroupTableVC.category = self.category
      
      //assign delegate object
      GroupTableVC.delegateObject = self
      
    }
  }
  
  //MARK:Actions
  
  //This method is called when the back button is called and brings the users 
  //back to the LFG page by dismissing the current view controller 
  @IBAction func BackToLFG(sender: UIButton) 
  {
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}


