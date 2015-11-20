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
  
  //Outdoor button
  @IBAction func OutdoorGroups(sender: UIButton) {
    
  }
  
  //Indoor button
  @IBAction func IndoorGroups(sender: UIButton) {
  }
  
  //Gym button
  //
  @IBAction func GymGroups(sender: UIButton) {
  }
  
  
  
  
}