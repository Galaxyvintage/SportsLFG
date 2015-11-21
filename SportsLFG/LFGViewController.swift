// 
// File   : LFGViewController.swift
// Author : Charles Li
// Date created: Nov.03 2015
// Date edited : Nov.20 2015
// Description:
// TODO: Need to implement the searching by category feature in version 2.0 in this file 
// 
//

import Foundation

class LFGViewController : UIViewController, UINavigationBarDelegate,UIBarPositioningDelegate
{
  //MARK:Properties
  @IBOutlet weak var navigationBar: UINavigationBar!
  
  var category : String?
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.delegate = self
  }
  
  
  
  ////////////////////
  //Delegate methods//
  ////////////////////
  
  /*UIBar*/
  
  func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
    return UIBarPosition.TopAttached
  }
  
  //MARK:Actions
  
  @IBAction func All(sender: UIButton)
  {
    category = "All"
    self.performSegueWithIdentifier("ShowGroups", sender: sender)
  }  
  @IBAction func OutdoorGroups(sender: UIButton) 
  {
    category = "Outdoor"
    self.performSegueWithIdentifier("ShowGroups", sender: sender)
  }
  
  //Indoor button
  @IBAction func IndoorGroups(sender: UIButton)
  {
    category = "Indoor"
    self.performSegueWithIdentifier("ShowGroups", sender: sender)
  }
  
  //Gym button
  //
  @IBAction func GymGroups(sender: UIButton) 
  {
    category = "Gym"
    self.performSegueWithIdentifier("ShowGroups", sender: sender)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "ShowGroups") {
      let navController = segue.destinationViewController as! UINavigationController
      let svc = navController.viewControllers[0] as! GroupTableViewController
      svc.category = category
    }
  }
  
  
}