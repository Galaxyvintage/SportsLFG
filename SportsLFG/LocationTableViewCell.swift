//
//  LocationTableViewCell.swift
//  SportsLFG
//
//  Created by Zheyang Li on 2015-12-05.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class LocationTableViewCell : UITableViewCell
{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var province: UITextField!
    
    weak var parentCell : TitleTableViewCell?
    
    weak var parentController : GroupTableViewController_2?
    
    weak var geocoder : CLGeocoder?
    
    weak var locationManager   : CLLocationManager?
    
    var groupLocation : String?
    
    var myCurrentLocation : CLLocation?

    override func awakeFromNib() {
        
        
    }
    
    
    @IBAction func validateLocation(sender: UIButton) {
        
        groupLocation = (address.text)! + ","
        groupLocation?.appendContentsOf((address.text)! + "," +
                                        (city.text)!    + "," +
                                        (province.text)!)
        
        geocoder!.geocodeAddressString(
            groupLocation!,
            completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
                
                if(errorOrNil != nil || placemarks == nil)
                {
                    //Error
                    self.parentCell?.rightLabel.text = "Unknown"
                    self.parentController?.isLocationValid = false
                    self.parentController!.showCancelUIAlert(
                        "Error",
                        titleComment   : "Group Creation Error",
                        message        : "Location is not valid",
                        messageComment : "Wrong Location")
                    return
                }
                else
                {
                    //Success
                    let firstPlacemark = placemarks?[0]
                    let location = (firstPlacemark!.location)!
                    let center = CLLocationCoordinate2DMake (location.coordinate.latitude, location.coordinate.longitude)

                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    
                    self.mapView!.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = center
                    self.mapView.addAnnotation(annotation)
                    
                    self.parentController!.showCancelUIAlert(
                        "Good",
                        titleComment   : "Location is OK",
                        message        : "Location is found",
                        messageComment : "OK Location")
                    return

                    //self.saveGroup(location)
                }
        })

    }
    deinit{
        print("location cell is released")
    }
}