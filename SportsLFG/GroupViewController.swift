//
//  GroupViewController.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-08.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var SportImageView: UIImageView!
    @IBOutlet weak var GroupNameLabel: UILabel!
    @IBOutlet weak var CreateDateLabel: UILabel!
    @IBOutlet weak var StartDateLabel: UILabel!
    @IBOutlet weak var StartTimeLabel: UILabel!
    @IBOutlet weak var ProvienceLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var MaxNumLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
