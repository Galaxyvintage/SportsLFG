//
// File : EditProfileController.swift
// Author :Charles Li
// Date created : Nov 03 2015
// Date modified: Nov 20 2015
// Description : This is class is used to handle personal information modification
// 
//

import Foundation

class EditProfileController : UIViewController
{

  @IBOutlet weak var name: UITextField!
  @IBOutlet weak var age:  UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var province: UITextField!
  @IBOutlet weak var gender: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add placeholder to text field 
    let currentGender = KCSUser.activeUser().getValueForAttribute("Gender") as? String
    
    if(currentGender == "Female")
    {
      gender.setOn(true, animated: true)
    }
    
  }
  
  func BackToHome()
  {
    let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController") 
    sharedFlag.gotoHome = true
    presentViewController(mainControllerView, animated: true,completion:nil)  
  }
  
  
  @IBAction func Back(sender: UIButton) {
    
     self.BackToHome()
  }
  
  
  @IBAction func SaveAndBack(sender: UIBarButtonItem) {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add placeholder to text field
    }
    
    func BackToHome()
    {
        let mainControllerView = self.storyboard!.instantiateViewControllerWithIdentifier("MainCVController")
        sharedFlag.gotoHome = true
        presentViewController(mainControllerView, animated: true,completion:nil)
    }
    
    
    @IBAction func Back(sender: UIButton) {
        
        self.BackToHome()
    }
    
    
    if(gender.on == true)
    {
      currentUser.setValue("Female", forAttribute: "Gender")
    }
    else 
    {
      currentUser.setValue("Male", forAttribute: "Gender")
    }
    currentUser.saveWithCompletionBlock { (NSarry:[AnyObject]!, errorOrNil:NSError!) -> Void in
      if (errorOrNil == nil)
      {
        self.BackToHome()
      }
      else
      {
        //inform user the error 
        NSLog("failed to save")
      }
    }

  }
}