//
// File  : GroupCreation.swift
// Author: Charles Li
// Date created  : Nov 04 2015
// Date modified : Nov 04 2015
// Description : 
//
import Foundation

class GroupCreation : UIViewController
{
   
  //MARK: Properties
  var sport :String!
  var currentType    : SportsType!
    
  //A flag to check whether user has enter all the needed information
  
  //must-enter attributes 
  var flag  :Bool!
  @IBOutlet weak var currentName: UITextField!
  @IBOutlet weak var maxSize: UITextField!
  @IBOutlet weak var address: UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var province: UITextField!
  @IBOutlet weak var time: UITextField!
  @IBOutlet weak var date: UITextField!
 
  
  
  //optional attributes 
  @IBOutlet weak var ageMin: UITextField?
  @IBOutlet weak var ageMax: UITextField?
  @IBOutlet var gender: [UIButton]?
  @IBOutlet weak var detail: UITextField?
  
  
  @IBOutlet var SportsButton: [UIButton]!
  
  
  
  @IBAction func PingPong(sender: UIButton) {
    sport        = "PingPong"
    currentType  = SportsType.Indoor
    
    for btn in SportsButton{
      btn.selected = false
    }
    sender.selected = true
  }
  
  @IBAction func Soccer(sender:UIButton) {
    sport        = "Soccer"
    currentType  = SportsType.Outdoor
    for btn in SportsButton{
      btn.selected = false
    }
    sender.selected = true
  }
  
  
  
  
  
  //This methods returns back to the LFG view controller
  @IBAction func BackToLFG(sender: UIButton) {
    NSLog("check")
    //unwind back to MainCVController 
    //set gotoLFG to true and perform segue to LFG controller
    let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController") 
    sharedFlag.gotoLFG = true
    self.presentViewController(mainControllerView, animated: true,completion:nil)      
  }
  
  
  
  
  //write information to the newGroup object
  @IBAction func createGroup(sender: UIButton) {
    
    
    ///////////////////////
    //Validate user input//
    ///////////////////////
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //The following 4 lines get the current date of the system
    let tempDate    = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
    let currentDate = formatter.stringFromDate(tempDate)
    
    
    
    //Kinvey API method that creates a store object 
    let store = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : "Groups", 
       KCSStoreKeyCollectionTemplateClass : Groups.self]
    )
    
    
    //Kinvey API method that creates a Groups instance and saving to the database
    //and assigns user input to the instance properties
    let group = Group(name       : currentName.text! ,
                      dateCreated: currentDate,
                      startTime  : time.text!, 
                      startDate  : date.text!, 
                      sport      : sport, 
                      maxSize    : maxSize.text!, 
                      address    : address.text!, 
                      city       : city.text!, 
                      province   : province.text!)
 
    group.metadata?.setGloballyWritable(false)
    
    //this method saves the changes and uploads the newly created entity to the database
    store.saveObject(
      group, 
      withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in 
        if errorOrNil != nil{
          
          //for checking which error domain 
          print(errorOrNil.domain)
          
          
          //create an alert to tell user there is an error
          let message = "Failed to create a group"
          let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: "error"),
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert  
          )
          let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
          alert.addAction(cancelAction)
          self.presentViewController(alert, animated: true, completion: nil)
          
        }else{
          
          //save was sucessful
          //bring user to their group page 
          //self.
          NSLog("Successfullly saved event(id ='%@').",(objectsOrNil[0] as! NSObject).kinveyObjectId())
        }
      },
      
      withProgressBlock : nil
    )  
  }  
}

