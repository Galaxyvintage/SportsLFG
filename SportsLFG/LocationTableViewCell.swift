//
//  LocationTableViewCell.swift
//  SportsLFG
//
//  Created by Zheyang Li on 2015-12-05.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//


import UIKit
import MapKit


class LocationTableViewCell : UITableViewCell
{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var Address: UITextField!
    
    @IBOutlet weak var City: UITextField!
    
    @IBOutlet weak var Province: UITextField!
    
    
    @IBAction func showLocation(sender: UIButton) {
        
        
        
    }
}