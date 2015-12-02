//
// File  : LocationViewController.swift
// Author:  Charles Li, Isaac Qiao
// Date created  : Nov.08 2015
// Date edited   : Nov.25 2015
// Description :  This class is responsible to show groups and locations 

import UIKit

class GroupTableViewController: UITableViewController
{
  
  // MARK: Properties
  var indicatorView : UIView!
  var activityIndicator : UIActivityIndicatorView!
  
  var category :String?
  var delegateObject : GroupLoadingProtocol?
  
  //an empty array of Group objects
  var groups = [Group]()
  
  //Kinvey API methods that create store objects for 
  //Group collection 
  let storeGroup = KCSAppdataStore.storeWithOptions(
    [KCSStoreKeyCollectionName : "Groups", 
      KCSStoreKeyCollectionTemplateClass : Group.self])
  
  //InGroup collection
  let storeInGroup = KCSAppdataStore.storeWithOptions(
    [KCSStoreKeyCollectionName : "InGroups", 
      KCSStoreKeyCollectionTemplateClass : inGroup.self])
  
  var dataLimit = 20 //loads 20 groups max each time
  var dataSkip  = 20 //skips 20 groups after loading the first time 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // activityIndicator Configure
    self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    self.indicatorView  = UIView(frame: self.tableView.frame)
    print(self.indicatorView)
    
    self.tableView.addSubview(self.indicatorView)
    
    self.indicatorView.addSubview(self.activityIndicator)
    self.indicatorView.hidden = true
    self.activityIndicator.center = CGPoint(x: self.indicatorView.center.x, y: 40.0)
    self.activityIndicator.frame  = self.indicatorView.frame
    self.activityIndicator.hidesWhenStopped = true
    
    self.indicatorView.backgroundColor     = UIColor.clearColor()
    self.activityIndicator.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.groups.count
    
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1
  }  
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  {
    let spacing = CGFloat(5)
    return spacing
    
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clearColor()
    return headerView
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "GroupTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
    
    // Fetches the appropriate group for the data source layout.
    let group = groups[indexPath.section]
    
    // Configure the cell...
    // Mandatory properties 
    cell.NameLabel.text       = "["+group.category!+"]"+group.name!
    cell.StartDateLabel.text  = group.startDate
    cell.StartTimeLabel.text  = group.startTime
    cell.ProvienceLabel.text  = group.province
    cell.CityLabel.text       = group.city
    cell.AddressLabel.text    = group.address
    cell.MaxNumberLabel.text  = String(group.currentSize!)+"/"+String(group.maxSize!)
    
    // Optional properties 
    
    
    // rounded corners 
    cell.layer.cornerRadius  = 10
    cell.layer.borderWidth   = 1
    cell.layer.masksToBounds = true
    
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
  
  
  
  //Helper function that displays the actitivy indiciator while loading data
  func update(query: KCSQuery?)
  {
    //self.tableView.bringSubviewToFront(self.indicatorView)
    self.indicatorView.hidden = false
    self.activityIndicator.hidden = false
    self.activityIndicator.startAnimating()
    self.performSelector(Selector("reloadGroupData:"), withObject: query , afterDelay: 0.001)
  }
  
  
  
  //This method will be called by the viewWillAppear method in 
  //LocationViewController 
  func reloadGroupData(locationQuery : KCSQuery?)
  {
    var temp_groups = [Group]()
    var query : KCSQuery
    
    
      
    if(category == "MyGroups")
    {
      let currentUserId = KCSUser.activeUser().userId
      var groupNames = [String]()
      
      //Get all the groups the current user is in from the InGroups collection
      query = KCSQuery(onField:"user",withExactMatchForValue:currentUserId)
      
      //Start Outer Query
      self.storeInGroup.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          
          if(errorOrNil != nil)
          {
            self.activityIndicator.stopAnimating()
            self.indicatorView.hidden = true
            // print(errorOrNil.userInfo["Kinvey.kinveyErrorCode"])          
            //print(errorOrNil.userInfo[KCSErrorInternalError])
            print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
            //Error TODO make an alert window
            
            return 
          }
          else if(objectsOrNil != nil)
          {
            for new_inGroup in objectsOrNil
            {
              let new_inGroup = new_inGroup as! inGroup
              groupNames.append(new_inGroup.groupName!)
            }
            
            
            //Get all the groups using the group names from the previous query         
            query = KCSQuery(onField: "name", usingConditional: .KCSIn, forValue: groupNames)
            
            if(locationQuery != nil)
            {
              query.addQuery(locationQuery)
            }
            
            
            
            //Start Inner Query
            self.storeGroup.queryWithQuery(
              query, 
              withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
                self.activityIndicator.stopAnimating()
                self.indicatorView.hidden = true
                
                if(errorOrNil != nil)
                {
                  //print(errorOrNil.userInfo["Kinvey.kinveyErrorCode"])
                  //print(errorOrNil.userInfo[KCSErrorInternalError])
                  print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
                  return //Error TODO make an alert windows  
                }
                else if(objectsOrNil != nil)
                { 
                  //Success
                  //there is at least one object 
                  for testGroup in objectsOrNil 
                  {
                    let newGroup = testGroup as! Group
                    temp_groups += [newGroup]  
                  }
                  self.groups.removeAll()
                  self.groups = temp_groups
                  self.delegateObject?.didFinishLoading(temp_groups)
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
  
      if(locationQuery != nil)
      {
        query.addQuery(locationQuery)
      }
      
      //This limit the query for the first 20 objects
      //TODO: need to add a function to load more in the next version
      // query.limitModifer = KCSQueryLimitModifier(limit: 20)
      //query.skipModifier = KCSQuerySkipModifier(withcount: 20)
      
      storeGroup.queryWithQuery(
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
          self.activityIndicator.stopAnimating()
          self.indicatorView.hidden = true
          
          NSLog("InCompletionBlock")
          if((errorOrNil) != nil)
          {
            print(errorOrNil.userInfo["Kinvey.kinveyErrorCode"])
            print(errorOrNil.userInfo[KCSErrorInternalError])
            print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
            //Error TODO make an alert window 
          }
          else if(errorOrNil == nil)
          {
            NSLog("error is nil")
            
            for testGroup in objectsOrNil 
            {
              let newGroup = testGroup as! Group
              
              //the following 5 log statements are for testing purposes 
              NSLog("newGroup's name is %@",newGroup.name!)
              NSLog("newGroup's sport is %@",newGroup.sport!)
              NSLog("newGroup's city is %@",newGroup.city!)
              NSLog("newGroup's province is %@",newGroup.province!)
              NSLog("newGroup's desc is %@",newGroup.detail!)
              temp_groups += [newGroup]  
            }
            self.groups.removeAll()
            self.groups = temp_groups
            self.delegateObject?.didFinishLoading(self.groups)
            self.tableView.reloadData()
          }
        }, 
        withProgressBlock: nil
      )
    }
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
        let selectedGroup = groups[indexPath.section]
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
