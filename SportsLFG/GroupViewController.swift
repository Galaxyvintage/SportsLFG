//
// File  : GroupViewController.swift
// Author: Aaron Cheung, Charles Li, Isaac Qiao
// Date created  : Nov.08 2015
// Date edited   : Nov.08 2015
// Description : This class is used in group view controller when users want to see
//               the detail information 
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
            navigationItem.title  = groupwork.name
            GroupNameLabel.text   = groupwork.name
            CreateDateLabel.text  = groupwork.dateCreated
            StartDateLabel.text   = groupwork.startDate
            StartTimeLabel.text   = groupwork.startTime
            ProvienceLabel.text   = groupwork.province
            CityLabel.text        = groupwork.city
            AddressLabel.text     = groupwork.address
            MaxNumLabel.text      = groupwork.maxSize
            
            //load the corresponding picture based on the name
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
    func joinGroup() 
    {
      let currentUserId    = KCSUser.activeUser().userId
      let currentGroupName = group!.name
      
      let store = KCSAppdataStore.storeWithOptions(
        [KCSStoreKeyCollectionName          : "inGroups", 
         KCSStoreKeyCollectionTemplateClass : Group.self])
    
      let query = KCSQuery(onField: "userId", withExactMatchForValue: currentUserId)
      
      store.queryWithQuery(
        
        query, 
        withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
        
          if(errorOrNil != nil)
          {
            //error 
          }
          else if(objectsOrNil == nil)
          {
            //add the user to the group
          }
          else 
          {
            for groupName in objectsOrNil
            {
              //user is in the group
              if(currentGroupName == (groupName as! inGroup).groupName)
              {
                let alert = UIAlertController(
                  title: NSLocalizedString("Hello", comment: "join a group"),
                  message: "looks like you are already in this group",
                  preferredStyle: UIAlertControllerStyle.Alert
                )
                let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true , completion: nil)
                return 
              }
            
            }
          
          //add the user to the group 
          }
        
        
        }, withProgressBlock: nil)
      
      
      
      
  }
  
  */
  //MARK: Actions
  
  /*
  @IBAction func JoinGroup(sender: UIBarButtonItem) {
    let alert = UIAlertController(
      title: NSLocalizedString("Hello", comment: "join a group"),
      message: "Do you wanna join this group?",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
      
      //addUser to the Group
      
      
    }
    let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    self.presentViewController(alert, animated: true , completion: nil)
    
  }
  */ 

}