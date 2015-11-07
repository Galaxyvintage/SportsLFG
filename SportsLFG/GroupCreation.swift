//
// File  : GroupCreation.swift
// Author: Charles Li
// Date created  : Nov 04 2015
// Date modified : Nov 04 2015
// Description : 
//
import Foundation

class GroupCreation : UIViewController, UITextFieldDelegate
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //set all the text fields' delegate to the view controller itself
    self.currentName.delegate = self;
    self.maxSize.delegate  = self;
    self.address.delegate  = self;
    self.city.delegate     = self;
    self.province.delegate = self;
    self.time.delegate     = self;
    self.date.delegate     = self;
    self.ageMin!.delegate  = self;
    self.ageMax!.delegate  = self;
    self.detail!.delegate  = self;
    
  }
  
  
  //This method  dismisses keyboard on return key press
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    self.view.endEditing(true)
    return false
  }
  
  //MThis method dismisses keyboard by touching to anywhere on the screen
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: Actions
  
  //////////
  //Sports//
  //////////
  
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
    
    
    //This checks if there is any mandatory fields is missing
    if(currentName.text?.isEmpty == true ||
       maxSize.text?.isEmpty     == true ||
       address.text?.isEmpty     == true ||
       city!.text?.isEmpty       == true ||
       province!.text?.isEmpty   == true ||
       time!.text?.isEmpty       == true ||
       date!.text?.isEmpty       == true  )
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error", comment: "account success note title"),
        message: NSLocalizedString("Empty field", comment: "password errors"),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
       
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    let group         = Groups()
    group.name        = currentName.text!  
    group.sport       = sport
    group.maxSize     = maxSize.text!
    group.startTime   = time.text!
    group.startDate   = date.text!
    group.dateCreated = currentDate
    group.address     = address.text!
    group.city        = city.text!
    group.province    = province.text!

    
    //this method saves the changes and uploads the newly created entity to the database
    store.saveObject(
      group, 
      withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in 
        if errorOrNil != nil{
          
          var message = "Failed to create a group"
          
          //for checking which error domain 
   
      
          print(errorOrNil.userInfo[KCSErrorCode])
          print(errorOrNil.userInfo[KCSErrorInternalError])
          print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
          
          //identify the error domain
       
          //create an alert to tell user there is an error
          
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

