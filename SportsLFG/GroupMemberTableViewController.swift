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
  
  weak var imageCache : NSCache!
  
  var storeUser    : KCSAppdataStore?
  var storeInGroup : KCSAppdataStore?
  var groupName    : String?
  var members = [Member]()
  
  
  
  func loadMember() {
    
    
    let groupQuery = KCSQuery(onField:"group",withExactMatchForValue:groupName)
    
    storeInGroup?.queryWithQuery(
      groupQuery,
      withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
        
        if(errorOrNil != nil)
        {
          //error 
        }
        else if(objectsOrNil != nil)
        {
          var userIds = [String]()
          for ingroup in objectsOrNil
          {
            userIds.append((ingroup as! inGroup).userId!)
          }
          
          
          self.storeUser?.loadObjectWithID(
            userIds, 
            withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil:NSError!) -> Void in
              
              if(errorOrNil != nil)
              {
                //error
              }
                
              else if (objectsOrNil != nil)
              {
                let users = objectsOrNil as! [KCSUser]
                var image : UIImage?
                var isImageFound : Bool = true
                for user in users
                {
                  let name     = user.getValueForAttribute("Name") as! String
                  let age      = user.getValueForAttribute("Age")  as! String
                  let gender   = user.getValueForAttribute("Gender") as! String

                  
                  image    = self.imageCache.objectForKey(name) as? UIImage
                  if(image == nil)
                  {
                    image = UIImage(named: "defaultPhoto")
                    isImageFound = false
                  }
                  
                  let newMember = Member(photo: image,name: name, age: age, gender: gender)
                  
                  self.members.append(newMember!)
                }  
                self.tableView.reloadData()
              
                if(!(isImageFound))
                {
                  KCSFileStore.downloadDataByName(
                    userIds, 
                    completionBlock: { (downloadedResources:[AnyObject]!, errorOrNil:NSError!) -> Void in
                      
                      //returned data array is empty
                      if(downloadedResources.count == 0)
                      {
                        return
                      }
                      else if (errorOrNil == nil)
                      {
                        
                        for var index = 0; index < downloadedResources.count; ++index 
                        {
                          print("index is \(index)")
                          
                          let file = downloadedResources[index] as! KCSFile
                          let fileData = file.data
                          var outputObject: NSObject! = nil
                          if file.mimeType.hasPrefix("text") 
                          {
                            outputObject = NSString(data: fileData, encoding: NSUTF8StringEncoding)
                          } 
                          else if file.mimeType.hasPrefix("image/jpeg") 
                          {
                            //save the downloaded image to the NSCache
                            outputObject = UIImage(data: fileData)
                            let image    = outputObject as? UIImage
                            
                            //TODO: user index could be mess up
                            self.imageCache.setObject(outputObject, forKey: self.members[index].name!) 
                            self.members[index].photo = image
                          }
                          NSLog("downloaded: %@", outputObject)
                        } 
                        self.tableView.reloadData()
                      } 
                      else 
                      {
                        NSLog("Got an error: %@", errorOrNil)
                      }
                    },
                    progressBlock: nil)//Photo download complete
                }
              }  
            }, 
            withProgressBlock: nil)//User information download complete
        }
      },
      withProgressBlock: nil)//UserId download complete
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSLog("viewDidLoad in GroupMemberTableViewController")
    self.imageCache = SharedImageCache.ImageCache.imageCache
    
    self.storeUser = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : KCSUserCollectionName,
        KCSStoreKeyCollectionTemplateClass : KCSUser.self])
    
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
