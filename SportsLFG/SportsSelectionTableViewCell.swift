//
//  SportsSelectionTableViewCell.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-28.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class SportsSelectionTableViewCell: UITableViewCell {

    
    var Sport : String?
    var Sports = [
        "Pingpong"  ,
        "Soccer"    ,
        "Basketball",
        "Running"   ,
        "Tennis"]
    @IBOutlet var SportsBtns: [UIButton]!
  
    @IBOutlet weak var userInput: UITextField!
    
    @IBAction func SportSelection(sender: UIButton!) {
        
        
        for btn in SportsBtns
        {
            btn.selected = false
        }
        
       sender.selected = true
       Sport = Sports[sender.tag] //each button has its own tag 
       print(Sport)
    }
    
}
