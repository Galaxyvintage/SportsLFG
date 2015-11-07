//
//  GroupCell.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-06.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation

class GroupCell : UITableViewCell{
 
  //MARK: Properties
  
  @IBOutlet weak var GroupImage: UIImageView!
  @IBOutlet weak var GroupName: UILabel!
  @IBOutlet weak var GroupSize: UILabel!
 
  @IBOutlet weak var Time: UILabel!
  @IBOutlet weak var Date: UILabel!
  @IBOutlet weak var Address: UIButton!
  @IBOutlet weak var City: UILabel!
  @IBOutlet weak var Province: UILabel!
  
  @IBOutlet var Gender: [UIImageView]!
  
  
}