//
//  LocationViewController.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-18.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager =  CLLocationManager()
    
    
    //-------------------------------------------------------
    //Kinvey API method that creates a store object
    let store = KCSAppdataStore.storeWithOptions(
        [KCSStoreKeyCollectionName : "Groups",
            KCSStoreKeyCollectionTemplateClass : Group.self])
    //-------------------------------------------------------
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        
        //-------------------------------------------------------
        let query = KCSQuery()
        
        //This limit the query for the first 20 objects
        //TODO: need to add a function to load more in the next version
        // query.limitModifer = KCSQueryLimitModifier(limit: 20)
        //query.skipModifier = KCSQuerySkipModifier(withcount: 20)
        
        store.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
                
                NSLog("InCompletionBlock1")
                if (errorOrNil != nil)
                {
                    NSLog("Load Database Error")
                    print(errorOrNil.userInfo[KCSErrorCode])
                    print(errorOrNil.userInfo[KCSErrorInternalError])
                    print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
                }
                else if(errorOrNil == nil)
                {
                    NSLog("error is nil")
                    
                    for testGroup in objectsOrNil
                    {
                        let newGroup = testGroup as! Group
                        
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
            },
            withProgressBlock: nil
        )
        //-------------------------------------------------------
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Location Delegate Methods
    
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
    
}
