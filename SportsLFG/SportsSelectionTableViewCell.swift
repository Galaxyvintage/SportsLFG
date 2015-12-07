//
//  SportsSelectionTableViewCell.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-28.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class SportsSelectionTableViewCell: UITableViewCell,UITextFieldDelegate
{
    
    @IBOutlet var SportsBtns: [UIButton]!
  
    @IBOutlet weak var userInput: UITextField!
  
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var sport : String?
    var sports = [
        "Pingpong"  ,
        "Soccer"    ,
        "Basketball",
        "Running"   ,
        "Tennis"]

    weak var parentCell : TitleTableViewCell?
    weak var parentController : GroupTableViewController_2?
    
    
    @IBAction func SportSelection(sender: UIButton!) {
        
        
        for btn in SportsBtns
        {
            btn.selected = false
        }
        
       sender.selected = true
       sport = sports[sender.tag] //each button has its own tag
       parentController?.dictOne[0] = sport
       parentController?.sport = sport
       parentCell?.rightLabel.text = sport
       parentCell?.rightLabel.textColor = UIColor.blackColor()
       print(sport)
    }
    
    
    
}
