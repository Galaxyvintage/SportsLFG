//
// File : FirstTimeUserViewController.swift
// Author :Charles Li
// Date created : Nov 02 2015
// Date modified: Nov 03 2015
// Description :

import Foundation

class FirstTimeUserViewController : UIViewController{
  
  //MARK: Properties 
  
  @IBOutlet weak var Name: UITextField!
  
  @IBOutlet weak var Age: UITextField!
  @IBOutlet weak var City: UITextField!
  @IBOutlet weak var Province: UITextField!
  
  //check whether user misses any field 
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
    
    if(isAnyEmptyField() == true)
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error", comment: ""),
        message: NSLocalizedString("Missing input", comment: ""),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
    
    
    //Add custom attributes to the user 
    //only for first time user 
    //more attribute can be set up later 
    currentUser.setValue(Name.text, forAttribute: "Name")
    currentUser.setValue(Age.text, forAttribute:"Age")
    currentUser.setValue(City.text, forAttribute:"City")
    currentUser.setValue(Province.text, forAttribute:"Province")
    
    

    currentUser.saveWithCompletionBlock { (NSarry:[AnyObject]!, errorOrNil:NSError!) -> Void in
      if (errorOrNil == nil)
      {
        //saved successfully
      }
      else
      {
        //update failed
      }
    }
    NSLog("Save")
    

    let mainControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("HomeController")
    self.presentViewController(mainControllerView!, animated: true, completion: nil)              
  }
}