//
//  GroupViewController.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-08.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    /*
    This value is passed by `GroupTableViewController` in `prepareForSegue(_:sender:)`
    */
    var group: Group?
    
    
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
        
        // Set up views if editing an existing Group.
        if let groupwork = group {
            navigationItem.title = groupwork.name
            GroupNameLabel.text   = groupwork.name
            CreateDateLabel.text = groupwork.dateCreated
            StartDateLabel.text = groupwork.startDate
            StartTimeLabel.text = groupwork.startTime
            ProvienceLabel.text = groupwork.province
            CityLabel.text = groupwork.city
            AddressLabel.text = groupwork.address
            MaxNumLabel.text = groupwork.maxSize
            switch groupwork.sport!{
            case "bB":
                let photo1 = UIImage(named: "Basketball-50_blue")!
                SportImageView.image = photo1
            case "Soccer":
                let photo1 = UIImage(named: "Football 2-50_blue")!
                SportImageView.image = photo1
            case "PingPong":
                let photo1 = UIImage(named: "Ping Pong-50_blue")!
                SportImageView.image = photo1
            case "R":
                let photo1 = UIImage(named: "Running-50_blue")!
                SportImageView.image = photo1
            default:
                let photod = UIImage(named: "defaultPhoto")!
                SportImageView.image = photod
                
            }
        }
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
