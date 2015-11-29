//
//  EnergyTableViewController .swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-29.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation
import UIKit


class EnergyTableViewController : UITableViewController
{
  let kAuthorizeHealthKitSection = 2
  let kProfileSegueIdentifier    = "profileSegue"
  
  let healthManager : HealthManager = HealthManager()
  
  func authorizeHealthKit()
  {
    print("TODO: Request HealthKit Authorization")
    
    healthManager.authorizeHealthKit{(authorized, error) -> Void in
      if authorized
      {
        print("HealthKit authorization received")
         let alert = UIAlertController(
          title: "Hello",
          message: "This app has been authorized successfully. Please go to the health app and change the settings under the Sources tab if needed", 
          preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(
          title: "OK", 
          style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        
        dispatch_async(dispatch_get_main_queue()) {
          // Do UI stuff here
          self.presentViewController(alert, animated: true, completion: nil) 
        }
        
      }
      else
      {
        print("HealthKit authorization denied!")
        if( error != nil)
        {
          print("\(error)")
        }
      }
    }  
  }
    
  // MARK: - TableView Delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch(indexPath.section, indexPath.row)
    {
    case(0,0):
      authorizeHealthKit()
    default:break
    }
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  
  
}