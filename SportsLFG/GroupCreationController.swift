//
// File  : GroupCreationController.swift
// Author: Charles Li, Aaron Cheung, Issac Qiao
// Date created  : Nov 04 2015
// Date modified : Nov 25 2015
// Description : This class is used in the group creation view controller and handles 
//               group creation request
//
import Foundation
import UIKit
import CoreLocation


class GroupCreationController: UIViewController,UIPickerViewDataSource, UITextFieldDelegate,UIPickerViewDelegate
{
  
  //MARK: Properties
  var sport :String!
  var category : String?
  var categoryArr = ["Outdoor","Indoor","Gym"]
  var timePicker  = UIDatePicker()
  var datePicker  = UIDatePicker()
  var geocoder    = CLGeocoder()
  var timeFormatter : NSDateFormatter? //for time 
  var dateFormatter : NSDateFormatter? //for date
  
  
  
  var activeTextField :UITextField?
  
  @IBOutlet weak var rootScrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var rootScrollViewBottomConstraint: NSLayoutConstraint!
  
  //must-enter attributes 
  @IBOutlet weak var currentName: UITextField!
  @IBOutlet weak var maxSize: UITextField!
  @IBOutlet weak var address: UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var province: UITextField!
  @IBOutlet weak var time: UITextField!
  @IBOutlet weak var date: UITextField!
  @IBOutlet weak var categoryPickerView: UIPickerView!
  
  
  //optional attributes 
  @IBOutlet weak var ageMin: UITextField?
  @IBOutlet weak var ageMax: UITextField?
  @IBOutlet var gender: [UIButton]?
  @IBOutlet weak var detail: UITextField?
  
  
  //@IBOutlet var SportsButton: [UIButton]!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //Single tap gestureRecognizer to dismiss keyboards
    let singleTap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboardInScrollView:"))
    rootScrollView.addGestureRecognizer(singleTap)
    singleTap.numberOfTapsRequired    = 1
    singleTap.numberOfTouchesRequired = 1
    
    //Register keyboard events
    let defaultCenter = NSNotificationCenter.defaultCenter()
    defaultCenter.addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
    
    defaultCenter.addObserver(self, selector: Selector("keyboardDidHide:"), name: UIKeyboardDidHideNotification, object: nil)
    
    //Set all the text fields' delegate to the view controller itself
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
    
    self.categoryPickerView.delegate   = self;
    self.categoryPickerView.dataSource = self;
    
    //set the PickerView to the first row and call the delegate method 
    self.categoryPickerView.selectRow(0, inComponent: 0, animated: true)
    self.pickerView(categoryPickerView, didSelectRow: 0, inComponent: 0)
    
    //Date and Time pickers configuration 
    let currentDate = NSDate()
    
    // Initial values for time and date
    let dateFormatter = NSDateFormatter()
    let timeFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    self.time.text = timeFormatter.stringFromDate(currentDate)
    self.date.text = dateFormatter.stringFromDate(currentDate)
    
    //Time 
    self.timePicker.datePickerMode = UIDatePickerMode.Time
    self.timePicker.minuteInterval = 5
    
    
    //This calls the updateTime method when the value is changed 
    self.timePicker.addTarget(self, action: Selector("updateTime"), forControlEvents: UIControlEvents.ValueChanged)
    self.time.inputView = self.timePicker
    
    //Date
    self.datePicker.datePickerMode = UIDatePickerMode.Date
    self.datePicker.minimumDate = NSDate()
    
    //This calls the updateDate method when the value is changed 
    self.datePicker.addTarget(self, action: Selector("updateDate"), forControlEvents: UIControlEvents.ValueChanged)
    self.date.inputView = self.datePicker
    
    self.detail!.text = "Come join in!"
    
  }
  
  ////////////////////
  //Selector methods//
  ////////////////////
  /*Gesture*/
  
  func hideKeyboardInScrollView(gesture: UITapGestureRecognizer) -> Void
  {
    self.rootScrollView.endEditing(true)
  }
  
  /*Time and Date pickerViews*/
  
  //This method is called when the value of the time picker is changed
  //and updates the text in the time textfield
  func updateTime()
  {
    self.timeFormatter = NSDateFormatter()
    timeFormatter!.timeStyle = NSDateFormatterStyle.ShortStyle
    let selectedTime = timeFormatter!.stringFromDate(timePicker.date)
    self.time.text = selectedTime 
  }
  
  //This method is called when the value of the date picker is changed
  //and updates the text in the date textfield
  func updateDate()
  {
    self.dateFormatter = NSDateFormatter()
    dateFormatter!.dateStyle = NSDateFormatterStyle.ShortStyle
    let selectedDate = dateFormatter!.stringFromDate(datePicker.date)
    self.date.text = selectedDate 
    
  }
  
  /*Keyboard*/
  
  //This changes the scrollview to a smaller size when the keyboard shows 
  func keyboardDidShow(keyboardNotif : NSNotification) -> Void 
  {
    //NSLog("keyboardWillShow")
    if let info = keyboardNotif.userInfo
    {
      if let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as?NSValue)?.CGRectValue().size
      {
        
        //update the constraint to resize the scroll view 
        let kbHeight  = keyboardSize.height
        
        if(rootScrollViewBottomConstraint.constant < kbHeight)
        {
          rootScrollViewBottomConstraint.constant = kbHeight
        }                
      }
    }
  }
  
  //This changes the scrollview size back to normal 
  func keyboardDidHide(keyboardNotif : NSNotification) -> Void 
  {
    //NSLog("keyboardWillHide")
    if let info = keyboardNotif.userInfo
    {
      if let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size
      {
        //update the constraint to resize the scroll view 
        let kbHeight  = keyboardSize.height
        rootScrollViewBottomConstraint.constant -= kbHeight
      }
    }
  }
  
  
  ////////////////////
  //Delegate methods//
  ////////////////////
  
  /*PickerView Delegates*/
  
  //This method is used to specify the number of cloumns in the picker elemnt
  func numberOfComponentsInPickerView(pickerView :UIPickerView) -> Int
  {
    return 1
  }
  
  //This method is used to specify the number of rows of data in the UIPickerView element
  func pickerView(pickerView : UIPickerView, numberOfRowsInComponent component: Int)->Int
  {
    return categoryArr.count
  }
  
  //This method is used to specify the data for a specific row and specific component
  func pickerView(pickerView : UIPickerView, titleForRow row :Int, forComponent component: Int) -> String?
  {
    return categoryArr[row]
  }
  
  
  func pickerView(pickerView : UIPickerView, didSelectRow row : Int, inComponent component : Int)
  {
    category = categoryArr[row]
  }
  
  
  /*TextField Delegates*/
  
  func textFieldDidBeginEditing(textField: UITextField)  
  { //Keyboard becomes visible
    //perform actions.
    self.activeTextField = textField
  }
  
  func textFieldDidEndEditing(textField: UITextField)  
  { //Keyboard becomes visible
    //perform actions.
    self.activeTextField = nil
  }
  
  //This method  dismisses keyboard on return key press
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    self.view.endEditing(true)
    return false
  }
  
  //This method dismisses keyboard by touching to anywhere on the screen
  override func touchesBegan(doubleTaps: Set<UITouch>, withEvent event: UIEvent?) {
    
    self.rootScrollView.endEditing(true)
  }
  
  
  ///////////////////
  //private methods//
  ///////////////////
  
  //This method takes a string and shows an alert with that message
  
  func showCancelUIAlert(title          : String,
    titleComment   : String,
    message        : String,
    messageComment : String)
  {
    let alert = UIAlertController(
      title  : NSLocalizedString(title, comment: titleComment),
      message: NSLocalizedString(message, comment: messageComment),
      preferredStyle : UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
    alert.addAction(cancelAction)
    presentViewController(alert, animated: true , completion: nil)
    return
    
    
  }
   
  // Sends group data to the database
  func saveGroup(groupLocation: CLLocation)
  {
    //Kinvey API method that creates a store object
    //so we can save entities to a specific collection
    let storeGroup = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : "Groups",
        KCSStoreKeyCollectionTemplateClass : Group.self]
    )
    
    
    //This creates a query that checks whether the item already exists by
    //changing the user input to all lowercases and comparing it to the database
    let query = KCSQuery(onField: "nameLowercase", withExactMatchForValue: currentName.text!.lowercaseString)
    
    //execute the query
    storeGroup.countWithQuery(query) { (count :UInt, errorOrNil :NSError!) -> Void in
      
      //if the group already exists
      if(errorOrNil != nil)
      {
        //there is an error, possibly internet error 
        return
        
      }
        
      else if(count > 0)
      {
        
        //create an alert to tell user there is an error
        let alert = UIAlertController(
          title  : NSLocalizedString("Error", comment: "error"),
          message: "Group already exists",
          preferredStyle: UIAlertControllerStyle.Alert)
        
        // how do i avoid duplicating this?
        let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        return
      }
        
      else if(Int(self.maxSize.text!)! <= 1)
      {
        //Prevent user from making a group with size of 1 or less
        let alert = UIAlertController(
          title : NSLocalizedString("Error", comment: "error"),
          message: "Group size must be at least 2",
          preferredStyle: UIAlertControllerStyle.Alert
        )
        // ...
        let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        return
      }
      
      //The following 4 lines get the current date of the system
      let tempDate  = NSDate()
      let formatter = NSDateFormatter()
      formatter.dateStyle = NSDateFormatterStyle.ShortStyle
      let currentDate = formatter.stringFromDate(tempDate)
      
      //Kinvey API method that creates a Group instance and saving to the database
      //and assigns user input to the instance properties
      let group = Group()
      
      //Mandatory properties 
      group.name          = self.currentName.text! 
      group.nameLowercase = self.currentName.text!.lowercaseString
      group.owner         = KCSUser.activeUser().userId
      group.dateCreated   = currentDate
      group.startTime     = self.time.text! 
      group.startDate     = self.date.text! 
      group.sport         = self.sport
      group.category      = self.category
      print(group.category)
      group.maxSize       = Int(self.maxSize.text!)! 
      group.currentSize   = 1  //only 1 member when it's first created 
      group.address       = self.address.text! 
      group.city          = self.city.text!
      group.province      = self.province.text!
      group.geoLocation      = groupLocation
      group.metadata?.setGloballyWritable(false)
      
      
      //Optional properties
    
        //Should already have been checked but redundancy
      if(self.detail!.text != nil)
      {
        group.detail  = self.detail!.text
      }
      
      //This method saves the changes and uploads the newly created entity to the database
      storeGroup.saveObject(
        group, 
        withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in 
          if (errorOrNil != nil)
          {
            print(errorOrNil.userInfo[KCSErrorCode])
            print(errorOrNil.userInfo[KCSErrorInternalError])
            print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
            
            //identify the error domain
            let message = errorOrNil.userInfo[NSLocalizedDescriptionKey] as! String?
            
            //create an alert to tell user there is an error
            let alert = UIAlertController(
              title  : NSLocalizedString("Error", comment: "error"),
              message: message,
              preferredStyle: UIAlertControllerStyle.Alert  
            )
            let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return 
            
          }
          else
          {
            //Save was sucessful
            //TODO:bring user to their group page 
            NSLog("Successfullly saved event(id ='%@').",(objectsOrNil[0] as! NSObject).kinveyObjectId())
            
            let alert = UIAlertController(
              title  : NSLocalizedString("Success", comment: "group is successfully created "),
              message: "Your group has been created ",
              preferredStyle: UIAlertControllerStyle.Alert  
            )
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
              
              //Todo:Bring user to their group 
              self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)              
          }
        },
        withProgressBlock : nil)
      
    }    
  }
  
  
  //MARK: Actions
  
  //////////
  //Sports//
  //////////
  /*
  @IBAction func PingPong(sender: UIButton) {
    sport = "PingPong"
    for btn in SportsButton{
      btn.selected = false
    }
    sender.selected = true
  }
  
  @IBAction func Soccer(sender:UIButton) {
    sport = "Soccer"
    for btn in SportsButton{
      btn.selected = false
    }
    sender.selected = true
  }
    
  @IBAction func Basketball(sender:UIButton) {
        sport = "Basketball" //basketball
        for btn in SportsButton{
            btn.selected = false
        }
        sender.selected = true
    }
    
    @IBAction func Running(sender: UIButton) {
        sport = "Basketball" //basketball
        for btn in SportsButton{
            btn.selected = false
        }
        sender.selected = true
    }
  */
  //This methods returns back to the LFG view controller
  @IBAction func BackToLFG(sender: UIButton) {
    NSLog("BackToLFG")
    
    //unwind back to MainCVController 
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)    
  }
  
  //write information to the newGroup object
  @IBAction func createGroup(sender: UIButton) {
    
    ///////////////////////
    //Validate user input//
    ///////////////////////
    
    //This checks if there is any mandatory fields is missing
    if(currentName.text?.isEmpty == true ||
      maxSize.text?.isEmpty      == true ||
      address.text?.isEmpty      == true ||
      city!.text?.isEmpty        == true ||
      province!.text?.isEmpty    == true ||
      time!.text?.isEmpty        == true ||
      date!.text?.isEmpty        == true ||
      sport                      == nil )
    {
      let alert = UIAlertController(
        title  : NSLocalizedString("Error", comment: "account success note title"),
        message: NSLocalizedString("Empty field", comment: "password errors"),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
    if (detail!.text?.isEmpty   == nil) {
        detail!.text = "Come join in!"
    }
    
    var groupLocation = (address.text)! + "," 
    groupLocation    += (city.text)! + "," + (province.text)!
    
    //This gets the geographic coordinates from an address string
    //using the geocoder class and returns an alert if the address is not found 
    geocoder.geocodeAddressString(
      groupLocation, 
      completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
        
        if(errorOrNil != nil || placemarks == nil)
        {
          //Error
          self.showCancelUIAlert("Error", 
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
          self.saveGroup(location)
        } 
    })
  }  
}

