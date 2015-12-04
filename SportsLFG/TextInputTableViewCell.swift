//
//  TextInputTableViewCell.swift
//  SportsLFG
//
//  Created by Charles Li on 2015-11-27.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {

    @IBOutlet weak var inputField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
