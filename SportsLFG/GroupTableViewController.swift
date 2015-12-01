//
// File  : LocationViewController.swift
// Author:  Charles Li, Isaac Qiao
// Date created  : Nov.08 2015
// Date edited   : Nov.25 2015
// Description :  
//

import UIKit

class GroupTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var category :String?
  
  var delegateObject : GroupLoadingProtocol?
  //an empty array of Group objects
  var groups = [Group]()
  
  //Kinvey API methods that create store objects for 
  //Group collection & InGroup collection
  let storeGroup = KCSAppdataStore.storeWithOptions(
    [KCSStoreKeyCollectionName : "Groups", 
      KCSStoreKeyCollectionTemplateClass : Group.self])
  
  let storeInGroup = KCSAppdataStore.storeWithOptions(
    [KCSStoreKeyCollectionName : "InGroups", 
      KCSStoreKeyCollectionTemplateClass : inGroup.self])
  
  
  
  override func viewDidAppear(animated: Bool) {

    super.viewDidAppear(animated)
    self.groups.removeAll()
    
    var query : KCSQuery
    
    if(category == "MyGroups")
    {
      let currentUserId = KCSUser.activeUser().userId
      var groupNames = [String]()
      
      query = KCSQuery(onField:"user",withExactMatchForValue:currentUserId)
      
      //get all the groupNames the currentUser is in
      storeInGroup.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          
          if(errorOrNil != nil)
          {
            return//error TODO make an alert windows   
          }
          else if(objectsOrNil != nil)
          {
            for new_inGroup in objectsOrNil
            {
              let new_inGroup = new_inGroup as! inGroup
              groupNames.append(new_inGroup.groupName!)
            }
            
            query = KCSQuery(onField: "name", usingConditional: .KCSIn, forValue: groupNames)
            
            self.storeGroup.queryWithQuery(
              query, 
              withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
                
                NSLog("InCompletionBlock")
                if(errorOrNil != nil)
                {
                  return //error TODO make an alert windows  
                }
                else if(objectsOrNil != nil)
                {
                  NSLog("error is nil")
                  
                  for testGroup in objectsOrNil 
                  {
                    let newGroup = testGroup as! Group
                    self.groups += [newGroup]  
                  }
                  self.delegateObject?.didFinishLoading(self.groups)
                  self.tableView.reloadData()
                } 
              },
              withProgressBlock: nil)//End Inner Query
          }
        }, 
        withProgressBlock: nil)//End Out Query
    }
    else
    {
      
      if(category == "All")
      {
        query = KCSQuery()
      }
      else if( category == "Outdoor")
      {
        query = KCSQuery(onField: "category", withExactMatchForValue: "Outdoor")
      }
      else if( category == "Indoor")
      {
        query = KCSQuery(onField: "category", withExactMatchForValue: "Indoor")
      }
      else //(category == "Gym")
      {
        query = KCSQuery(onField: "category", withExactMatchForValue: "Gym")
      }
      //This limit the query for the first 20 objects
      //TODO: need to add a function to load more in the next version
      // query.limitModifer = KCSQueryLimitModifier(limit: 20)
      //query.skipModifier = KCSQuerySkipModifier(withcount: 20)
      
      storeGroup.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          
          NSLog("InCompletionBlock")
          if(errorOrNil == nil)
          {
            NSLog("error is nil")
            
            for testGroup in objectsOrNil 
            {
              let newGroup = testGroup as! Group
              
              //the following 4 log statements are for testing purposes 
              NSLog("newGroup's name is %@",newGroup.name!)
              NSLog("newGroup's sport is %@",newGroup.sport!)
              NSLog("newGroup's city is %@",newGroup.city!)
              NSLog("newGroup's province is %@",newGroup.province!)
              
              self.groups += [newGroup]  
            }
            self.delegateObject?.didFinishLoading(self.groups)
            self.tableView.reloadData()
          }
        }, 
        withProgressBlock: nil
      )
    }
  }
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
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
    return groups.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "GroupTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
    
    // Fetches the appropriate group for the data source layout.
    let group = groups[indexPath.row]
    
    // Configure the cell...
    cell.NameLabel.text       = "["+group.category!+"]"+group.name!
    cell.StartDateLabel.text  = group.startDate
    cell.StartTimeLabel.text  = group.startTime
    cell.ProvienceLabel.text  = group.province
    cell.CityLabel.text       = group.city
    cell.AddressLabel.text    = group.address
    cell.MaxNumberLabel.text  = String(group.currentSize!)+"/"+String(group.maxSize!)
    
    //cell.SportTypeImageView.image using switch, need to further change
    switch group.sport!{
    case "Basketball":
      let photo1 = UIImage(named: "Basketball-50_blue")!
      cell.SportTypeImageView.image = photo1
    case "Soccer":
      let photo1 = UIImage(named: "Football 2-50_blue")!
      cell.SportTypeImageView.image = photo1
    case "PingPong":
      let photo1 = UIImage(named: "Ping Pong-50_blue")!
      cell.SportTypeImageView.image = photo1
    case "Running":
      let photo1 = UIImage(named: "Running-50_blue")!
      cell.SportTypeImageView.image = photo1
    case "Tennis":
      let photo1 = UIImage(named: "Tennis-50_red")!
      cell.SportTypeImageView.image = photo1
        
    default:
      let alp = group.sport!.uppercaseString
      let photoname = alp[alp.startIndex.advancedBy(0)]
      let photod = UIImage(named: "\(photoname)")!
      cell.SportTypeImageView.image = photod
      
    }
    
    return cell
  }
  
  //MARK:Actions
  
  
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
        let selectedGroup = groups[indexPath.row]
        groupDetailViewController.group = selectedGroup
        
        NSLog(self.category!)
        if(self.category == "MyGroups")
        {
          NSLog("Leave")
          groupDetailViewController.UIBarButtonItemTitle = "Leave"
        }
        else
        {
          NSLog("Join")
          groupDetailViewController.UIBarButtonItemTitle = "Join"
        }
      }
    }
      
    else if segue.identifier == "AddGroup" {
      print("Adding new group.")
    }
  }
}
