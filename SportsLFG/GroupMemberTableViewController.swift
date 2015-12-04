//
//  GroupMemberTableViewController.swift
//  SportsLFG
//
//  Created by Isaac Qiao on 2015-11-30.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupMemberTableViewController: UITableViewController {
  
  // MARK: Properties
  
  
  var storeGroup   : KCSAppdataStore?
  var storeInGroup : KCSAppdataStore?
  var groupName    : String?
  var members = [Member]()
  

  
  func loadMember() {
      
  
    
    /*
    let photo1 = UIImage(named: "Male-25")!
    let m1 = Member(photo: photo1, name: "nan1",age: "22", gender: "man", location:"sfu")!
    
    let photo2 = UIImage(named: "Female-25")!
    let f1 = Member(photo: photo2, name: "nv1",age: "20", gender: "woman", location:"sfulibrary")!
    
    let photo3 = UIImage(named: "Male-25")!
    let m2 = Member(photo: photo3, name: "nv1",age: "21", gender: "man", location:"sfuasb")!
    
    members += [m1, f1, m2]
    */
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.storeGroup = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : "Groups",
        KCSStoreKeyCollectionTemplateClass : Group.self])
    
    //InGroup collection
    self.storeInGroup = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : "InGroups",
        KCSStoreKeyCollectionTemplateClass : inGroup.self])
    
    
    // Load the sample data.
    loadMember()
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
    return members.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "GroupMemberTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupMemberTableViewCell
    
    // Fetches the appropriate meal for the data source layout.
    let member = members[indexPath.row]
    
    cell.nameLabel.text = member.name
    cell.photoImageView.image = member.photo
    cell.ageLabel.text = member.age
    cell.genderLabel.text = member.gender
    cell.locationLabel.text = member.location
    
    return cell
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
