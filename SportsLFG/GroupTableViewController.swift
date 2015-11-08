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
  
    // This is a helper method to load sample data into the app.
    // Can be further change when know how to use database load data
    func loadData()
    {
      // sampel self created groups in groups array
      /*
        let G1 = Group(name: "Group1", dateCreated: "Created date 1", startTime  : "startTime1", startDate  : "startDate2", sport  : "bB", maxSize : "11", address: "add1", city    : "city1", province: "P1")
        let G2 = Group(name: "Group2", dateCreated: "Created date 2", startTime  : "startTime2", startDate  : "startDate2", sport  : "Soccer", maxSize : "22", address: "add2", city    : "city2", province: "P2")
        let G3 = Group(name: "Group3", dateCreated: "Created date 3", startTime  : "startTime3", startDate  : "startDate3", sport  : "PingPong", maxSize : "33", address: "add3", city    : "city3", province: "P3")
        let G4 = Group(name: "Group4", dateCreated: "Created date 4", startTime  : "startTime4", startDate  : "startDate4", sport  : "R", maxSize : "44", address: "add4", city    : "city4", province: "P4")
        retrieveInitialData() 
        NSLog("Check")
        groupA += [G1,G2,G3,G4]
      */
      
    }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      /*
      store.loadObjectWithID(
        "563dce2ca3025e212b01f5fc",
        withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
          if errorOrNil == nil {
            NSLog("successful reload: %@", objectsOrNil[0] as! Group) // event updated
          
            NSLog("Group name is: %@",(objectsOrNil[0] as! Group).dateCreated!)
            
          } else {
            NSLog("error occurred: %@", errorOrNil)
          }
        },
        withProgressBlock: nil
      )
      
      */
      let query = KCSQuery()
      query.limitModifer = KCSQueryLimitModifier(limit: 20)
      query.skipModifier = KCSQuerySkipModifier(withcount: 20)
      
      store.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          
          NSLog("InCompletionBlock")
          if(errorOrNil == nil)
          {
            NSLog("error is nil")
            
            let rtnGroups = objectsOrNil as! [Group]
            
            NSLog("return group array's size is %ld",rtnGroups.count)
            
            /*
            NSLog("return group array's size is %ld",rtnGroups.count)
            for i in  rtnGroups as! [Group]
            {
              self.groups.append(i)
              
            }
            */
            self.loadData()
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
       
      // Fetches the appropriate meal for the data source layout.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
