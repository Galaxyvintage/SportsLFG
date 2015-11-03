//
// File : FirstTimeUserViewController.swift
// Author :Charles Li
// Date created : Nov 02 2015
// Date modified: Nov 02 2015
// Description :

import Foundation

class FirstTimeUserViewController : UIViewController{
  

  //TODO:
  //      1.Add fields to collect user information for first-time user
  
  

  
  
  
  @IBAction func SaveAndGoToMainPage(sender: UIButton) {
    let currentUser = KCSUser.activeUser()
    currentUser.setValue(0, forAttribute:"Age")
    currentUser.setValue(0, forAttribute:"City")
    currentUser.setValue(0, forAttribute:"Province")
    currentUser.setValue(0, forAttribute:"Country")
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