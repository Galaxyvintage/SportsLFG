//
// File  : GroupCreationController.swift
// Author: Charles Li
// Date created  : Nov 04 2015
// Date modified : Nov 04 2015
// Description : This is class is used in the group creation view controller and handles
//               group creation request
//
import Foundation

//TODO:
//     1. Save the sportType when the group is created
//     2. Verify user address using CLLocation manager
//     3. Let user pick their location using the map
//     4. Let user pick province and location using pickers


class GroupCreationController: UIViewController,UIPickerViewDataSource, UITextFieldDelegate,UIPickerViewDelegate
{
    
    //MARK: Properties
    var sport :String!
    var sportType : String?
    var sportTypeArr = ["Outdoor","Indoor","Gym"]
    
    //must-enter attributes
    @IBOutlet weak var currentName: UITextField!
    @IBOutlet weak var maxSize: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var sportTypePickerView: UIPickerView!
    
    
    //optional attributes
    @IBOutlet weak var ageMin: UITextField?
    @IBOutlet weak var ageMax: UITextField?
    @IBOutlet var gender: [UIButton]?
    @IBOutlet weak var detail: UITextField?
    
    
    @IBOutlet var SportsButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set all the text fields' delegate to the view controller itself
        self.currentName.delegate = self;
        self.maxSize.delegate  = self;
        self.address.delegate  = self;
        self.city.delegate     = self;
        self.province.delegate = self;
        self.time.delegate     = self;
        self.date.delegate     = self;
        self.ageMin!.delegate  = self;
        self.ageMax!.delegate  = self;
        self.detail!.delegate  = self;
        
        self.sportTypePickerView.delegate   = self;
        self.sportTypePickerView.dataSource = self;
        
    }
    
    //This method is used to specify the number of cloumns in the picker elemnt
    func numberOfComponentsInPickerView(pickerView :UIPickerView) -> Int
    {
        return 1
    }
    
    //This method is used to specify the number of rows of data in the UIPickerView element
    func pickerView(pickerView : UIPickerView, numberOfRowsInComponent component: Int)->Int
    {
        return sportTypeArr.count
    }
    
    //This method is used to specify the data for a specific row and specific component
    func pickerView(pickerView : UIPickerView, titleForRow row :Int, forComponent component: Int) -> String?
    {
        return sportTypeArr[row]
    }
    
    
    func pickerView(pickerView : UIPickerView, didSelectRow row : Int, inComponent component : Int)
    {
        sportType = sportTypeArr[row]
    }
    
    //This method  dismisses keyboard on return key press
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    
    //MThis method dismisses keyboard by touching to anywhere on the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Actions
    
    //////////
    //Sports//
    //////////
    
    @IBAction func PingPong(sender: UIButton) {
        sport        = "PingPong"
        for btn in SportsButton{
            btn.selected = false
        }
        sender.selected = true
    }
    
    @IBAction func Soccer(sender:UIButton) {
        sport        = "Soccer"
        for btn in SportsButton{
            btn.selected = false
        }
        sender.selected = true
    }
    
    
    
    
    
    //This methods returns back to the LFG view controller
    @IBAction func BackToLFG(sender: UIButton) {
        NSLog("BackToLFG")
        
        //unwind back to MainCVController
        //set gotoLFG to true and perform segue to LFG controller
        let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController")
        sharedFlag.gotoLFG = true
        self.presentViewController(mainControllerView, animated: true,completion:nil)
    }
    
    
    
    
    //write information to the newGroup object
    @IBAction func createGroup(sender: UIButton) {
        
        
        ///////////////////////
        //Validate user input//
        ///////////////////////
        
        
        //This checks if there is any mandatory fields is missing
        if(currentName.text?.isEmpty == true ||
            maxSize.text?.isEmpty     == true ||
            address.text?.isEmpty     == true ||
            city!.text?.isEmpty       == true ||
            province!.text?.isEmpty   == true ||
            time!.text?.isEmpty       == true ||
            date!.text?.isEmpty       == true ||
            sport                     == nil )
        {
            let alert = UIAlertController(
                title  : NSLocalizedString("Error", comment: "account success note title"),
                message: NSLocalizedString("Empty field", comment: "password errors"),
                preferredStyle : UIAlertControllerStyle.Alert
            )
            
            let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(cancelAction)
            presentViewController(alert, animated: true , completion: nil)
            return
        }
        
        //Kinvey API method that creates a store object
        //so we can save entities to a specific collection
        let storeGroup = KCSAppdataStore.storeWithOptions(
            [KCSStoreKeyCollectionName : "Groups",
                KCSStoreKeyCollectionTemplateClass : Group.self]
        )
        
        let storeInGroup = KCSAppdataStore.storeWithOptions(
            [KCSStoreKeyCollectionName          : "InGroups",
                KCSStoreKeyCollectionTemplateClass : inGroup.self])
        
        
        
        //This creates a query that checks whether the item already exists by
        //changing the user input to all lowercases and comparing it to the database
        let query = KCSQuery(onField: "nameLowercase", withExactMatchForValue: currentName.text!.lowercaseString)
        
        //execute the query
        storeGroup.countWithQuery(query) { (count :UInt, errorOrNil :NSError!) -> Void in
            
            //if the group already exists
            if(count > 0)
            {
                
                //create an alert to tell user there is an error
                let alert = UIAlertController(
                    title  : NSLocalizedString("Error", comment: "error"),
                    message: "Group already exists",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            
            
            //The following 4 lines get the current date of the system
            let tempDate  = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            let currentDate = formatter.stringFromDate(tempDate)
            
            //Kinvey API method that creates a Group instance and saving to the database
            //and assigns user input to the instance properties
            let group = Group()
            
            
            group.name          = self.currentName.text!
            group.nameLowercase = self.currentName.text!.lowercaseString
            group.owner         = KCSUser.activeUser().userId
            group.dateCreated   = currentDate
            group.startTime     = self.time.text!
            group.startDate     = self.date.text!
            group.sport         = self.sport
            group.maxSize       = Int(self.maxSize.text!)!
            group.currentSize   = 0                //only 1 member when it's first created
            group.address       = self.address.text!
            group.city          = self.city.text!
            group.province      = self.province.text!
            group.metadata?.setGloballyWritable(false)
            
            //This method saves the changes and uploads the newly created entity to the database
            storeGroup.saveObject(
                group,
                withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
                    if (errorOrNil != nil)
                    {
                        
                        print(errorOrNil.userInfo[KCSErrorCode])
                        print(errorOrNil.userInfo[KCSErrorInternalError])
                        print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
                        
                        //identify the error domain
                        let message = errorOrNil.userInfo[KCSErrorInternalError] as! String?
                        
                        //create an alert to tell user there is an error
                        let alert = UIAlertController(
                            title  : NSLocalizedString("Error", comment: "error"),
                            message: message,
                            preferredStyle: UIAlertControllerStyle.Alert
                        )
                        let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                        alert.addAction(cancelAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        return
                        
                    }
                    else
                    {
                        //save was sucessful
                        //TODO:bring user to their group page
                        NSLog("Successfullly saved event(id ='%@').",(objectsOrNil[0] as! NSObject).kinveyObjectId())
                        
                        let currentUserId    = KCSUser.activeUser().userId
                        let currentGroupName = group.name
                        
                        
                        //add the user to the group
                        let userInGroup = inGroup()
                        userInGroup.userId = currentUserId
                        userInGroup.groupName = currentGroupName
                        storeInGroup.saveObject(
                            userInGroup,
                            withCompletionBlock: { (objectsOrNil:[AnyObject]!, errorOrNil : NSError!) -> Void in
                                
                                if(errorOrNil != nil)
                                {
                                    NSLog("Check")
                                    
                                    print(errorOrNil.userInfo[KCSErrorCode])
                                    print(errorOrNil.userInfo[KCSErrorInternalError])
                                    print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
                                    //error
                                    //prompt the user to save their info again
                                    
                                }
                                else if(objectsOrNil != nil)
                                {
                                    //saved successfully
                                    let checkInGroup = objectsOrNil[0] as! inGroup
                                    NSLog("userID:%@",checkInGroup.userId!)
                                    NSLog("groupName:%@",checkInGroup.groupName!)
                                    
                                    //information must be uploadded to the InGroup relationship collection 
                                    //on our backend database before the  current view disappears 
                                    let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController") 
                                    sharedFlag.gotoLFG = true
                                    self.presentViewController(mainControllerView, animated: true,completion:nil)      
                                    
                                }
                                
                            }, 
                            withProgressBlock: nil)
                    }
                },
                
                withProgressBlock : nil)
        }    
    }  
}

