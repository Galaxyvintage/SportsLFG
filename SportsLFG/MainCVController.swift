// 
// File   : MainCVController.swift
// Author : Charles Li
// Date created: Oct.11 2015
// Date edited : Oct.15 2015
// Description:
import Foundation


import Foundation

class MainCVController : UIViewController{
  
  
  var currentViewController: UIViewController!
  @IBOutlet var TabBarButtons: Array<UIButton>!  
  @IBOutlet var CV: UIView!
  override func viewDidLoad() {
    
    super.viewDidLoad()
    NSLog("check1")
    if(TabBarButtons.count > 0) {
      performSegueWithIdentifier("Home", sender: TabBarButtons[0])

    }
  }
  
  
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