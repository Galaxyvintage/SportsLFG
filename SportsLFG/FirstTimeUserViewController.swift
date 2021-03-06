//
// File : FirstTimeUserViewController.swift
// Author :Charles Li
// Date created : Nov 02 2015
// Date modified: Nov 22 2015
// Description :  This class is used by the first time user view controller and it's for
//                either first time users

import Foundation

class FirstTimeUserViewController : UIViewController, UITextFieldDelegate{
  
  
  //MARK: Properties 
  var gender : String?
  
  
  @IBOutlet weak var Name: UITextField!
  @IBOutlet weak var Age : UITextField!
  @IBOutlet weak var City: UITextField!
  @IBOutlet weak var Province: UITextField!
  @IBOutlet weak var genderSwitch: UISwitch!
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //set all the textfields's delegate to its view controller
    self.Name.delegate = self
    self.Age.delegate  = self
    self.City.delegate = self
    self.Province.delegate  = self
  }
  
  //This method  dismisses keyboard on return key press
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    self.view.endEditing(true)
    return false
  }
  
  //This method dismisses keyboard by touching to anywhere on the screen
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  
  //This checks whether user misses any field
  func isAnyEmptyField()->Bool
  {
    if( Name!.text     == nil || 
      Age!.text      == nil ||
      City!.text     == nil ||
      Province!.text == nil )
    {
      return true
    }
    return false
  }
  
  
  //MARK:Actions
  @IBAction func SaveAndGoToMainPage(sender: UIButton) {
    let currentUser = KCSUser.activeUser()
    
    //This is run if there is an empty field
    
    if(isAnyEmptyField() == true)
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error",         comment: ""),
        message: NSLocalizedString("Missing input", comment: ""),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
    
    
    if(genderSwitch.on == true)
    {
      self.gender = "Female"
    }
    else
    {
      self.gender = "Male"
    }
    
    //This adds custom attributes to the user 
    //It's only for the first time user 
    //notes: more attribute can be set up later
    
    currentUser.setValue(Name.text, forAttribute:"Name")
    currentUser.setValue(Age.text, forAttribute:"Age")
    currentUser.setValue(City.text, forAttribute:"City")
    currentUser.setValue(Province.text, forAttribute:"Province")
    currentUser.setValue(gender, forAttribute:"Gender")
    
    //This method saves the custom attributes to the kinvey back-end database
    
    currentUser.saveWithCompletionBlock { (NSarry:[AnyObject]!, errorOrNil:NSError!) -> Void in
      if (errorOrNil == nil)
      {
        //saved successfully
      }
      else
      {
        //update failed
        //need to inform user if save goes wrong 
      }
    }
    NSLog("Save")
    
    //After saving user info, the following presents the home view controller 
    
    let mainControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("MainCVController")
    self.presentViewController(mainControllerView!, animated: true, completion: nil)              
  }
}