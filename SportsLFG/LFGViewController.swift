//
// File   : LFGViewController.swift
// Author : Charles Li
// Date created: Nov.03 2015
// Date edited : Nov.22 2015
// Description:  This class is used to search groups by category 
//

import Foundation

class LFGViewController : UIViewController, UINavigationBarDelegate,UIBarPositioningDelegate
{
  //MARK:Properties
  var category : String?
  
  @IBOutlet weak var navigationBar: UINavigationBar!
  
  @IBOutlet weak var All: UIButton!
  @IBOutlet weak var Outdoor: UIButton!
  @IBOutlet weak var Indoor: UIButton!
  @IBOutlet weak var Gym: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.delegate = self
    
    All.layer.cornerRadius     = 10
    Outdoor.layer.cornerRadius = 10
    Indoor.layer.cornerRadius  = 10
    Gym.layer.cornerRadius     = 10
  
  }
  
  ////////////////////
  //Delegate methods//
  ////////////////////
  
  /*UIBar*/
  
  func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
    return UIBarPosition.TopAttached
  }
  
  //MARK:Actions
  //Following methods pass the category data to the GroupTableView 
  //based on which button is pressed 
  
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
    if (segue.identifier == "ShowGroups") 
    {
      let navController = segue.destinationViewController as! UINavigationController
      let container = navController.viewControllers[0] as! LocationViewController
      
      //pass the category information to the container view controller
      container.category = category!
      
    }
  }
  
  
}