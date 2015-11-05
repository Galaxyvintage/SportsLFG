// 
// File   : MainCVController.swift
// Author : Charles Li
// Date created: Oct.11 2015
// Date edited : Oct.15 2015
// Description:
import Foundation


import Foundation


//global flags 
//they are used to determine which segue to perform
//need to be set back to false when the segue is about to be fired
class sharedFlag{
  
  static var gotoHome = false
  static var gotoLFG  = false
  static var gotoTeam = false

}


class MainCVController : UIViewController{
    var currentViewController: UIViewController!
  @IBOutlet var TabBarButtons: Array<UIButton>!  
  @IBOutlet var CV: UIView!
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    //NSLog("check1")
    if(sharedFlag.gotoLFG == true)
    {
      sharedFlag.gotoLFG = false
      performSegueWithIdentifier("LFG", sender: TabBarButtons[1])
    }
      
    else if(TabBarButtons.count > 0) {
      performSegueWithIdentifier("Home", sender: TabBarButtons[0])

    }
  }
  
  //This method prepare the segue and change the sender button's state to selected 
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let availableIdentifiers = ["Home","LFG","Team/Group"]
    
    if(availableIdentifiers.contains(segue.identifier!)) {
      
      for btn in TabBarButtons {
        btn.selected = false
      }
      
      let senderBtn = sender as! UIButton
      senderBtn.selected = true
      
    }
  }
  
}  