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
  var groupA = [Group]()
    
  //Kinvey API method that creates a store object 
  let store = KCSAppdataStore.storeWithOptions(
  [KCSStoreKeyCollectionName : "Groups", 
   KCSStoreKeyCollectionTemplateClass : Group.self])
  
    func retrieveInitialData() 
    {
    }
  
    override func viewDidLoad() {
      super.viewDidLoad()
        
    
      let query = KCSQuery()
      //query.limitModifer = KCSQueryLimitModifier(limit: 20)
      //query.skipModifier = KCSQuerySkipModifier(withcount: 20)
      
      store.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          
          NSLog("InCompletionBlock")
          if(errorOrNil == nil)
          {
            NSLog("error is nil")
            
            for testGroup in objectsOrNil 
            {
              let newGroup = testGroup as! Group
             
              NSLog("newGroup's name is %@",newGroup.name!)
              NSLog("newGroup's sport is %@",newGroup.sport!)
              NSLog("newGroup's city is %@",newGroup.city!)
              NSLog("newGroup's province is %@",newGroup.province!)
              self.groupA += [newGroup]  
            }
            self.tableView.reloadData()
          }
        }, 
        withProgressBlock: nil
      )
      
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupA.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GroupTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
       
        // Fetches the appropriate group for the data source layout.
        let group = groupA[indexPath.row]
        
        // Configure the cell...
        cell.NameLabel.text       = group.name
        cell.StartDateLabel.text  = group.startDate
        cell.StartTimeLabel.text  = group.startTime
        cell.CreateDateLabel.text = group.dateCreated
        cell.ProvienceLabel.text  = group.province
        cell.CityLabel.text    = group.city
        cell.AddressLabel.text = group.address
        cell.MaxNumberLabel.text = group.maxSize
        //cell.SportTypeImageView.image using switch, need to further change
        switch group.sport!{
        case "bB":
            let photo1 = UIImage(named: "Basketball-50_blue")!
            cell.SportTypeImageView.image = photo1
        case "Soccer":
            let photo1 = UIImage(named: "Football 2-50_blue")!
            cell.SportTypeImageView.image = photo1
        case "PingPong":
            let photo1 = UIImage(named: "Ping Pong-50_blue")!
            cell.SportTypeImageView.image = photo1
        case "R":
            let photo1 = UIImage(named: "Running-50_blue")!
            cell.SportTypeImageView.image = photo1
        default:
            let photod = UIImage(named: "defaultPhoto")!
            cell.SportTypeImageView.image = photod
            
        }
        
        return cell
    }
    
  //MARK:Actions

  
  @IBAction func BackToLFG(sender: UIButton) {
    NSLog("BackToLFG")
    //unwind back to MainCVController 
    //set gotoLFG to true and perform segue to LFG controller
    let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController") 
    sharedFlag.gotoLFG = true
    self.presentViewController(mainControllerView, animated: true,completion:nil)      
  
  
  }
  
  
  
  
  
  
  
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let groupDetailViewController = segue.destinationViewController as! GroupViewController
            
            // Get the cell that generated this segue.
            if let selectedGroupCell = sender as? GroupTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedGroupCell)!
                let selectedGroup = groupA[indexPath.row]
                groupDetailViewController.group = selectedGroup
            }
        }
        else if segue.identifier == "AddGroup" {
            print("Adding new group.")
        }
    }
    

}
