// 
// File   : GroupTableViewController.swift
// Author : Isaac Qiao ,Charles Li
// Date created: Nov.05 2015
// Date edited : Nov.08 2015
// Description : This is the cell class that is used in the Group table view class when 
// 
//
import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var SportTypeImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var StartDateLabel: UILabel!
    @IBOutlet weak var StartTimeLabel: UILabel!
    //@IBOutlet weak var CreateDateLabel: UILabel!
    @IBOutlet weak var ProvienceLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var MaxNumberLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
