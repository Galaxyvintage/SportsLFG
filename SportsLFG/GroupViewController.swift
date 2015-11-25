//
// File  : GroupViewController.swift
// Author: Aaron Cheung, Charles Li, Isaac Qiao
// Date created  : Nov.08 2015
// Date edited   : Nov.24 2015
// Description : This class is used in group view controller when users want to see
//               the detail information
//

import UIKit
// Import Kits for map view
import MapKit
import CoreLocation

class GroupViewController: UIViewController {
  
  /*
  This value is passed by `GroupTableViewController` in `prepareForSegue(_:sender:)`
  */
  var group: Group?
  var UIBarButtonItemTitle : String?
  
  // MARK: Properties
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var GroupNameLabel: UILabel!
  @IBOutlet weak var CreateDateLabel: UILabel!
  @IBOutlet weak var StartDateLabel: UILabel!
  @IBOutlet weak var StartTimeLabel: UILabel!
  @IBOutlet weak var ProvienceLabel: UILabel!
  @IBOutlet weak var CityLabel: UILabel!
  @IBOutlet weak var AddressLabel: UILabel!
  @IBOutlet weak var MaxNumLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let RightButtonItem = UIBarButtonItem(title: UIBarButtonItemTitle, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("LeftBarButtonPressed:"))
    
    NSLog("title is %@ ",UIBarButtonItemTitle!)
    self.navigationItem.rightBarButtonItem = RightButtonItem
    
    
    // Do any additional setup after loading the view.
    
    //RightBarButtonItem.title = self.UIBarButtonItemTitle
    
    // Set up views if editing an existing Group.
    if let groupwork = group {
      navigationItem.title  = groupwork.name
      GroupNameLabel.text   = groupwork.name
      CreateDateLabel.text  = groupwork.dateCreated
      StartDateLabel.text   = groupwork.startDate
      StartTimeLabel.text   = groupwork.startTime
      ProvienceLabel.text   = groupwork.province
      CityLabel.text        = groupwork.city
      AddressLabel.text     = groupwork.address
      MaxNumLabel.text      = String(groupwork.maxSize)
      
      // map view
      var groupLocation =  (groupwork.address)! + ","
      groupLocation += (groupwork.city)! + ","
      groupLocation += (groupwork.province)!
      NSLog(groupLocation)
      let geocoder = CLGeocoder()
      geocoder.geocodeAddressString(groupLocation, completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
        
        if errorOrNil != nil
        {
          
          
        }
          
        else if let firstPlacemark = placemarks?[0] {
          //print(firstPlacemark)
          let location = firstPlacemark.location!
          let center = CLLocationCoordinate2DMake (location.coordinate.latitude, location.coordinate.longitude)
          print(location.coordinate.latitude)
          print(location.coordinate.longitude)
          let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
          
          let region = MKCoordinateRegion(center : center, span : span)
          
          let annotation = MKPointAnnotation()
          annotation.coordinate = center
          annotation.title = (groupwork.name)!
          
          self.mapView.addAnnotation(annotation)
          self.mapView.setRegion(region, animated: true)
          
        }
        
      })
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //This method adds the current user to the group
  func joinGroup()
  {
    let currentUserId = KCSUser.activeUser().userId
    let currentGroupName = group!.name 
    let store = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName          : "InGroups",
        KCSStoreKeyCollectionTemplateClass : inGroup.self])
    
    let query = KCSQuery(onField:"user", withExactMatchForValue: currentUserId)
    
    //query to check whether the user is already in the group
    store.queryWithQuery(
      query,
      withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
        
        if(errorOrNil != nil)
        {
          //error
          NSLog("error1")
          print(errorOrNil.userInfo[KCSErrorCode])
          print(errorOrNil.userInfo[KCSErrorInternalError])
          print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
          return
        }
        else if(objectsOrNil != nil)
        {
          //add the user to the group
          let userInGroup = inGroup()
          userInGroup.userId = currentUserId
          userInGroup.groupName = currentGroupName
          store.saveObject(
            userInGroup,
            withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil : NSError!) -> Void in
              
              if(errorOrNil != nil)
              {
                //error
                let message = errorOrNil.userInfo[NSLocalizedDescriptionKey];
                
                let alert = UIAlertController(
                  title: NSLocalizedString("Sorry", comment: "error"),
                  message: message as? String,
                  preferredStyle: UIAlertControllerStyle.Alert
                )
                let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true , completion: nil)
                return
                
              }
              else if(objectsOrNil != nil)
              {
                //saved successfully
                let checkInGroup = objectsOrNil[0] as! inGroup
                NSLog("userID:%@",checkInGroup.userId!)
                NSLog("groupName:%@",checkInGroup.groupName!)
              }
              
            }, 
            withProgressBlock: nil)
        }
        
      },
      withProgressBlock: nil)
  }
  
  //This method removes the current user from the grop
  func leaveGroup()
  {
    let currentUserId = KCSUser.activeUser().userId   
    let currentGroupName = group!.name 
    let store = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName          : "InGroups",
        KCSStoreKeyCollectionTemplateClass : inGroup.self])
    
    let nameQuery  = KCSQuery(onField:"user", withExactMatchForValue: currentUserId)
    let groupQuery = KCSQuery(onField:"group",withExactMatchForValue: currentGroupName)
    
    let combinedQuery = nameQuery.queryByJoiningQuery(groupQuery, usingOperator: KCSQueryConditional.KCSAnd)

    
    store.removeObject(
      combinedQuery, 
      withCompletionBlock: { (count:UInt, errorOrNil : NSError!) -> Void in
        if(errorOrNil != nil)
        {
          NSLog("error2")
          print(errorOrNil.userInfo[KCSErrorCode])
          print(errorOrNil.userInfo[KCSErrorInternalError])
          print(errorOrNil.userInfo[NSLocalizedDescriptionKey])

          return//error, deletion failed
        }
          
        else
        {
          let alert = UIAlertController(
            title: NSLocalizedString("Hello", comment: "successful deletion"),
            message: "You have left this group",
            preferredStyle: UIAlertControllerStyle.Alert)
          let cancelAction = UIAlertAction(title :"Ok", style: UIAlertActionStyle.Cancel, handler: nil)
          alert.addAction(cancelAction)
          self.presentViewController(alert, animated: true , completion: nil)
          
        }
        
      }, withProgressBlock: nil)
    
  }
  
  
  //This method gets called when the right bar button is pressed
  func LeftBarButtonPressed(sender : UIBarButtonItem) {
    
    if(sender.title! == "Join")
    {
      let alert = UIAlertController(
        title: NSLocalizedString("Hello", comment: "join a group"),
        message: "Do you wanna join this group?",
        preferredStyle: UIAlertControllerStyle.Alert
      )
      let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
        
        //add user to the Group
        self.joinGroup()
        
      }
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(okAction)
      alert.addAction(cancelAction)
      self.presentViewController(alert, animated: true , completion: nil)
      
    }
    else
    {
      let alert = UIAlertController(
        title: NSLocalizedString("Hello", comment: "leave a group"),
        message: "Do you wanna leave this group?",
        preferredStyle: UIAlertControllerStyle.Alert
      )
      let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
        
        //remove user from the Group
        self.leaveGroup()
        
      }
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(okAction)
      alert.addAction(cancelAction)
      self.presentViewController(alert, animated: true , completion: nil)
    }
    
  } 
}
