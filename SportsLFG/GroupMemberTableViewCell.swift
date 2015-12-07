//
//  GroupMemberTableViewCell.swift
//  SportsLFG
//
//  Created by Isaac Qiao on 2015-11-30.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupMemberTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
