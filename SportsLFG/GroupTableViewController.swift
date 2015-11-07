//
//  GroupTableViewController.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-06.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    // MARK: Properties
    
    //an empty array of Group objects
    var groups = [Group]()
    
    // This is a helper method to load sample data into the app.
    // Can be further change when know how to use database load data
    func loadSampleMeals() {
        
        // sampel self created groups in groups array
        let G1 = Group(name: "Group1", dateCreated: "Created date 1", startTime  : "startTime1", startDate  : "startDate2", sport  : "sport1", maxSize : "11", address: "add1", city    : "city1", province: "P1")
        let G2 = Group(name: "Group2", dateCreated: "Created date 2", startTime  : "startTime2", startDate  : "startDate2", sport  : "sport2", maxSize : "22", address: "add2", city    : "city2", province: "P2")
        let G3 = Group(name: "Group3", dateCreated: "Created date 3", startTime  : "startTime3", startDate  : "startDate3", sport  : "sport3", maxSize : "33", address: "add3", city    : "city3", province: "P3")
        let G4 = Group(name: "Group4", dateCreated: "Created date 4", startTime  : "startTime4", startDate  : "startDate4", sport  : "sport4", maxSize : "44", address: "add4", city    : "city4", province: "P4")
        
        groups += [G1,G2,G3,G4]
        groups += [G1,G2,G3,G4]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Load the sample data.
        loadSampleMeals()
    }

    func loadSampleGroups() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
