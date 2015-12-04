//
// File   : LocationViewController.swift
// Author : Isaac Qiao, Charles Li
// Date created: Nov.18 2015
// Date edited : 11.31 2015
// Description: This is class is responsible for loading the group data and displaying in
//              a table view and on a map at the same time
//
// Created by IsaacQ on 2015-11-18.
// Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreGraphics


//This protocol is used as a delegate to pass data back from
//GroupTableViewControllerto LocationViewController
protocol GroupLoadingProtocol : class
{
    func didFinishLoading(groups:[Group])
}

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,GroupLoadingProtocol
{
  
  //MARK:Properties
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var groupsContainer: UIView!
  @IBOutlet weak var rangeSelector: UISegmentedControl!
  
  var category : String = "MyGroups"
  weak var groupTableVC : GroupTableViewController!
  var locationManager   : CLLocationManager?
  var myCurrentLocation : CLLocation?
  var annotationContainer : [MKPointAnnotation]?
  
  override func viewWillAppear(animated: Bool) {
    //before the view appears
    super.viewWillAppear(animated)
    
    //reload data in the  group table view controller(child view controller) 
    self.groupTableVC = self.childViewControllers[0] as! GroupTableViewController
    
    //reset dataSkip back to zero
    groupTableVC.dataSkip = 0
    groupTableVC.groups?.removeAll()
    groupTableVC.update(nil)
    
    
    //might be not necessary since it's already called in
    //reloadGroupData()
    //groupTableVC.tableView.reloadData()
  }
  
  override func viewDidLoad() {
    
    override func viewWillAppear(animated: Bool) {
        //before the view appears
        super.viewWillAppear(animated)
        
        //reload data in the  group table view controller(child view controller)
        groupTableVC = self.childViewControllers[0] as! GroupTableViewController
        groupTableVC.update(nil)
        
        //might be not necessary since it's already called in
        //reloadGroupData()
        //groupTableVC.tableView.reloadData()
    }
    
    NSLog("viewDidLoad")
    self.annotationContainer = [MKPointAnnotation]()
    
    self.locationManager = CLLocationManager()
    
    self.rangeSelector.selectedSegmentIndex = 3
    
    self.locationManager!.delegate = self
    
    self.locationManager!.requestWhenInUseAuthorization()
    
    self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
    
    self.locationManager!.startUpdatingLocation()
    
    if(locationManager!.location != nil)
    {
      self.myCurrentLocation = locationManager!.location
    }
    
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
    
    self.mapView.removeAnnotations(self.annotationContainer!)
    
    for groupwork in groups
    {
      
      // here write the things about pins
      
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
          
          self.annotationContainer!.append(annotation)
          self.mapView.addAnnotation(annotation)
        }
      })
    }
    
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    self.mapView.setRegion(region, animated: true)
    
    self.locationManager!.stopUpdatingLocation()
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
    
    ////////////////////
    //Selector Methods//
    ////////////////////
    
    func reloadDataBasedOnSelectedSegment()
    {
      let myLatitude  = Double(self.myCurrentLocation!.coordinate.latitude)
      let myLongitude = Double(self.myCurrentLocation!.coordinate.longitude)
      print(myLatitude,myLongitude)
      var query : KCSQuery?
      
      switch self.rangeSelector.selectedSegmentIndex
      {
      case 0://5km or 3.1 miles approx.
        query = KCSQuery(
          onField: KCSEntityKeyGeolocation,
          usingConditionalPairs:[
            KCSQueryConditional.KCSNearSphere.rawValue,[myLongitude,myLatitude],
            KCSQueryConditional.KCSMaxDistance.rawValue, 3.1
          ])
      case 1://10km
        query = KCSQuery(
          onField: KCSEntityKeyGeolocation,
          usingConditionalPairs:[
            KCSQueryConditional.KCSNearSphere.rawValue,[myLongitude,myLatitude],
            KCSQueryConditional.KCSMaxDistance.rawValue, 9.3
          ])
      case 2://15km
        query = KCSQuery(
          onField: KCSEntityKeyGeolocation,
          usingConditionalPairs:[
            KCSQueryConditional.KCSNearSphere.rawValue,[myLongitude,myLatitude],
            KCSQueryConditional.KCSMaxDistance.rawValue, 27.9
          ])
        
      case 3://All
        query = nil
      default:break
      }
      
      self.groupTableVC.update(query)
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

