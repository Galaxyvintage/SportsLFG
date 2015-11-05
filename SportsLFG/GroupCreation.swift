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
  
  var sport :String!
  var newGroup: Group!
    
  //A flag to check whether user has enter all the needed information
  var flag  :Bool!
  @IBOutlet weak var groupName: UITextField!
  @IBOutlet weak var name: UITextField!
  
  
  @IBAction func PingPong(sender: UIButton) {
    sport = "PingPong"
  }
  @IBAction func Soccer(sender:UIButton) {
    sport = "Soccer"
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
  
  
}

