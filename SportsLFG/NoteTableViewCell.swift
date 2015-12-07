//
//  NoteTableViewCell.swift
//  SportsLFG
//
//  Created by Zheyang Li on 2015-12-05.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation
import UIKit

class NotetableViewCell : UITableViewCell
{
    
    @IBOutlet weak var noteContent: UITextView!
    
    weak var parentController : GroupTableViewController_2?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteContent.delegate = parentController
    }
    
}