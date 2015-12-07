//
//  TextInputTableViewCell.swift
//  SportsLFG
//
//  Created by Charles Li on 2015-11-27.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell,UITextFieldDelegate {
  
  @IBOutlet weak var inputField: UITextField!
  
  weak var parentCell : TitleTableViewCell?
  
  weak var parentController : GroupTableViewController_2?
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
