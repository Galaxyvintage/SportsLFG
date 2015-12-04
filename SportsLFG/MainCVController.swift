//
// File   : MainCVController.swift
// Author : Charles Li
// Date created: Oct.11 2015
// Date edited : Dec.04 2015
// Description: This is responsible for the main tab bar view controller(custom control) and
//loads different view depending on the selected button


import UIKit

class MainCVController : UIViewController
{
  
  //MARK: Properties
  
  var currentViewController: UIViewController!
  
  @IBOutlet weak var CV: UIView!
  //@IBOutlet var TabBarButtons: [UIButton]!
  @IBOutlet weak var Home: UIButton!
  @IBOutlet weak var LFG: UIButton!
  @IBOutlet weak var MyGroups: UIButton!
  @IBOutlet weak var Energy: UIButton!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    //Go to the home page when it's first loaded
    performSegueWithIdentifier("Home", sender: Home)
    
  }
  
  //This method prepare the segue and change the sender button's state to selected
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let availableIdentifiers = ["Home","LFG"]
    
    if(availableIdentifiers.contains(segue.identifier!)) {
      
      Home.selected     = false 
      LFG.selected      = false
      MyGroups.selected = false
      Energy.selected   = false
      
      (sender as! UIButton).selected = true
    }
    
    //This sets the parent variable to the current view controller
    if(segue.identifier == "Home")
    {
      let HVController = segue.destinationViewController as! HomeViewController
      HVController.parent = self
      
    }
  }
  
  deinit{
    
    print("MainCVControlller is released")
    
    
  }
  
}

