//
// File  : GroupViewController.swift
// Author: Aaron Cheung, Charles Li, Isaac Qiao
// Date created  : Nov.08 2015
// Date edited   : Nov.30 2015
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
  var currentView : UIView!
  var activityIndicator : UIActivityIndicatorView!
  
  
  // MARK: Properties
  @IBOutlet weak var mapView: MKMapView!

  @IBOutlet weak var CreateDateLabel: UILabel!
  @IBOutlet weak var StartDateLabel: UILabel!
  @IBOutlet weak var StartTimeLabel: UILabel!
  @IBOutlet weak var ProvienceLabel: UILabel!
  @IBOutlet weak var CityLabel: UILabel!
  @IBOutlet weak var AddressLabel: UILabel!
  @IBOutlet weak var MaxNumLabel: UILabel!
  @IBOutlet weak var Description: UITextView!
  
  //@IBOutlet weak var DetailView: UITextView!
  override func viewDidLoad() {
    // Do any additional setup after loading the view.
    super.viewDidLoad()
    
    // Spinner Config
    self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)


    self.view.addSubview(self.activityIndicator)
    self.activityIndicator.frame  = self.view.frame
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
    
    // UIBarButtonItem Config for Join and Leave 
    let RightButtonItem = UIBarButtonItem(title : UIBarButtonItemTitle, 
      style : UIBarButtonItemStyle.Plain, 
      target: self, 
      action: Selector("LeftBarButtonPressed:"))
    
    self.navigationItem.rightBarButtonItem = RightButtonItem
    
    //changeRightButtonTitle()
    //RightBarButtonItem.title = self.UIBarButtonItemTitle
    
    // Set up views if editing an existing Group.
    if let groupwork = group {
      navigationItem.title  = groupwork.name
    
      CreateDateLabel.text  = groupwork.dateCreated
      StartDateLabel.text   = groupwork.startDate
      StartTimeLabel.text   = groupwork.startTime
      ProvienceLabel.text   = groupwork.province
      CityLabel.text        = groupwork.city
      AddressLabel.text     = groupwork.address
      MaxNumLabel.text      = String(groupwork.currentSize!) + "/" + String(groupwork.maxSize!)
      
      
      if(groupwork.detail!.isEmpty)
      {
        // insert a default description or leave blank or afafaf
        // should already been dealt with at creation but just in case
        Description.text = "Description: " + "Come join in!"
      } else 
      {
        Description.text = "Description: " + (groupwork.detail)!
      }
      
      // map view
      var groupLocation =  (groupwork.address)! + ","
      groupLocation += (groupwork.city)! + ","
      groupLocation += (groupwork.province)!
      NSLog(groupLocation)
      let geocoder = CLGeocoder()
      geocoder.geocodeAddressString(
        groupLocation, 
        completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
          
          if errorOrNil != nil
          {
            
            
          }
          else if let firstPlacemark = placemarks?[0] 
          {
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
    /*
    //I want to update the size as the user joins/leaves but right now you can't see the update until you back all the way out to home
    func updateSize() {
        let groupwork = group
        MaxNumLabel.text = (String(groupwork!.currentSize!) + "/" + String(groupwork!.maxSize!))
        NSLog("updateSize "+String(groupwork!.currentSize!))
    }
    */
   
    // Changes the right "Join/Leave" button to the appropriate one
    func changeRightButtonTitle() {
        let currentUserId = KCSUser.activeUser().userId
        let currentGroupName = group!.name
        let store = KCSAppdataStore.storeWithOptions(
            [KCSStoreKeyCollectionName          : "InGroups",
                KCSStoreKeyCollectionTemplateClass : inGroup.self])
        
        
        let nameQuery  = KCSQuery(onField:"user", withExactMatchForValue: currentUserId)
        let groupQuery = KCSQuery(onField:"group",withExactMatchForValue: currentGroupName)!
        
        nameQuery.addQuery(groupQuery)
        
        //query to check whether the user is already in the group
        store.queryWithQuery(
            nameQuery,
            withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
                
                if(errorOrNil != nil)
                {
                    self.activityIndicator.stopAnimating()
                    //error
                    NSLog("error1")
                    print(errorOrNil.userInfo[KCSErrorCode])
                    print(errorOrNil.userInfo[KCSErrorInternalError])
                    print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
                    return
                }
                else if(objectsOrNil != nil && objectsOrNil.count == 0)
                {
                    NSLog("viewDidAppear: not in group")
                    //not in the group
                    self.navigationItem.rightBarButtonItem!.title = "Join"
                }
                else
                {
                    self.activityIndicator.stopAnimating()
                    NSLog("viewDidAppear: is in group")
                    self.navigationItem.rightBarButtonItem!.title = "Leave"
                }
            },
            withProgressBlock: nil)
    }
    
    //override viewDidAppear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        changeRightButtonTitle()
        //updateSize()
    }
    
    //override viewDidDisappear
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.removeFromSuperview()
        mapView = nil
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //This method adds the current user to the group
  func joinGroup()
  {
    //Check to see if the user fulfills the group age/gender restrictions.
    if(userMeetsRequirements() == false) {
        self.activityIndicator.stopAnimating()
        NSLog("doesn't meet requirements")
        let alert = UIAlertController(
            title: NSLocalizedString("Sorry", comment: "error"),
            message: "You do not meet the requirements of this group.",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let cancelAction = UIAlertAction(title  :"Cancel",
            style  : UIAlertActionStyle.Cancel,
            handler: {(action: UIAlertAction!) in
                self.navigationController?.popViewControllerAnimated(true)
        })
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true , completion: nil)
        return
    }
    
    let currentUserId = KCSUser.activeUser().userId
    let currentGroupName = group!.name 
    let store = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName          : "InGroups",
        KCSStoreKeyCollectionTemplateClass : inGroup.self])
    
    
    let nameQuery  = KCSQuery(onField:"user", withExactMatchForValue: currentUserId)
    let groupQuery = KCSQuery(onField:"group",withExactMatchForValue: currentGroupName)!
    
    nameQuery.addQuery(groupQuery)
    
    //query to check whether the user is already in the group
    store.queryWithQuery(
      nameQuery,
      withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
        
        if(errorOrNil != nil)
        {
          self.activityIndicator.stopAnimating()
          //error
          NSLog("error1")
          print(errorOrNil.userInfo[KCSErrorCode])
          print(errorOrNil.userInfo[KCSErrorInternalError])
          print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
          return
        }
        else if(objectsOrNil != nil && objectsOrNil.count == 0)
        {
          NSLog("no error")
          //add the user to the group
          let userInGroup = inGroup()
          userInGroup.userId = currentUserId
          userInGroup.groupName = currentGroupName
          store.saveObject(
            userInGroup,
            withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil : NSError!) -> Void in
              
              self.activityIndicator.stopAnimating()
              if(errorOrNil != nil)
              {
                //error
                NSLog("error is not nil111111")
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
                
                
                let alert = UIAlertController(
                  title: NSLocalizedString("Congratz", comment: "success"),
                  message:"You have joined this group successfully",
                  preferredStyle: UIAlertControllerStyle.Alert
                )
                let okAction = UIAlertAction(title  :"OK", 
                  style  : UIAlertActionStyle.Cancel,
                  handler: nil)
                alert.addAction(okAction)
                
                self.presentViewController(alert, animated: true , completion: nil)
                self.viewDidAppear(true)
                return
              }
            }, 
            withProgressBlock: nil)
        }
        else
        {
          self.activityIndicator.stopAnimating()
          NSLog("in group")
          print(objectsOrNil)
          let alert = UIAlertController(
            title: NSLocalizedString("Sorry", comment: "error"),
            message: "It looks like you are already in this group",
            preferredStyle: UIAlertControllerStyle.Alert
          )
          let cancelAction = UIAlertAction(title  :"Cancel", 
            style  : UIAlertActionStyle.Cancel,
            handler: {(action: UIAlertAction!) in
                self.navigationController?.popViewControllerAnimated(true)
            })
          alert.addAction(cancelAction)
          self.presentViewController(alert, animated: true , completion: nil)
          self.viewDidAppear(true)
          return
          
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
    
    nameQuery.addQuery(groupQuery)
    
    store.removeObject(
      nameQuery, 
      withCompletionBlock: {(count:UInt, errorOrNil : NSError!) -> Void in
        
        self.activityIndicator.stopAnimating()
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
          
          let okAction = UIAlertAction(title  :"Ok", 
            style  : UIAlertActionStyle.Cancel,
            handler: {(cancelAction : UIAlertAction)-> Void in
            self.navigationController?.popViewControllerAnimated(true)
          })
          alert.addAction(okAction)
          self.presentViewController(alert, animated: true , completion: nil)
        }
      }, 
      withProgressBlock: nil)
  }
  
  //Helper function that select the correct function 
  func update(condition : String)
  {
    self.view.bringSubviewToFront(self.activityIndicator)
    self.activityIndicator.hidden = false
    self.activityIndicator.startAnimating()
    if(condition == "Join")
    {
      self.performSelector("joinGroup", withObject: nil, afterDelay: 0.001)
    }
    else
    {
      self.performSelector("leaveGroup", withObject: nil, afterDelay: 0.001)
    }
    
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
      let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){(UIAlertAction) -> Void in
        
        //add user to the Group
        self.update("Join")
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
      let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){(UIAlertAction) -> Void in
        
        //remove user from the Group
        self.update("Leave")
        
      }
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(okAction)
      alert.addAction(cancelAction)
      self.presentViewController(alert, animated: true , completion: nil)
    }
    
  }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // pass the group to the next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMembers" {
        let MemberViewController = segue.destinationViewController as?GroupMemberTableViewController
            MemberViewController!.group = self.group
        }
    }
    
    func userMeetsRequirements() -> Bool {
        var ageOK = false
        var genderOK = false
        let user = KCSUser.activeUser()
        let myAge       = user.getValueForAttribute("Age") as! Int
        let myGender    = user.getValueForAttribute("Gender") as! String
        let groupMinAge = self.group!.minAge! as Int
        let groupMaxAge = self.group!.maxAge! as Int
        let groupGender = self.group!.gender!
        
        //Start age check
        if (groupMinAge == -1 && groupMaxAge == -1) {
            // age restriction not set (both = -1)
            ageOK = true
        } else if (groupMinAge != -1 && groupMaxAge == -1) {
            //min is set and max is not set (max = -1)
            if (myAge >= groupMinAge) {
                ageOK = true
            }
        } else if (groupMinAge == -1 && groupMaxAge != -1) {
            // max is set but min is not set (min = -1)
            if (myAge <= groupMaxAge) {
                ageOK = true
            }
        } else {
            if (myAge <= groupMaxAge && myAge >= groupMinAge) {
                //both are set
                ageOK = true
            } else {
                ageOK = false
            }
        }
        // Start gender check
        if (groupGender == "Neutral" || (myGender == groupGender)) {
            genderOK = true
        } else {
            genderOK = false
        }
        //User meets requirements if passes both age and gender check
        if (ageOK && genderOK) {
            return true
        } else {
            return false
        }
    }
    
    
  deinit{
    
    print("GroupView Controller is released")
  }  
}


