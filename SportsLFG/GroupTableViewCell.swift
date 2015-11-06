//
//  GroupTableViewCell.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-05.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var otherView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
