//
//  MainCVController.swift
//  SwiftLFG_64
//
//  Created by CharlesL on 2015-10-11.
//  Copyright (c) 2015 CharlesL. All rights reserved.
//

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