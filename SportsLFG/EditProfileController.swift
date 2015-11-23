//
// File : EditProfileController.swift
// Author :Charles Li, Aaron Cheung
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
  
  var delegateObject : ProfileUpdatingProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add placeholder to text field according to user's existing information
    let currentGender = KCSUser.activeUser().getValueForAttribute("Gender") as? String
    let myName      = KCSUser.activeUser().getValueForAttribute("Name") as! String
    let myAge       = KCSUser.activeUser().getValueForAttribute("Age") as! String
    let myCity  = KCSUser.activeUser().getValueForAttribute("City") as! String
    let myProvince = KCSUser.activeUser().getValueForAttribute("Province") as! String
    
    name.text = myName
    age.text = myAge
    city.text = myCity
    province.text = myProvince
    
    // set gender switch to correct gender
    if(currentGender == "Female")
    {
      gender.setOn(true, animated: true)
    }
    
  }
  
  func BackToHome()
  {
    //Dismiss order (right to left)
    //HomeView Controller<- Root View Controller
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func Back(sender: UIButton) {
    
    self.BackToHome()
    
  }
  
  
  @IBAction func SaveAndBack(sender: UIBarButtonItem) {
    
    let currentUser = KCSUser.activeUser()
    if(!(name.text!.isEmpty))
    {
      currentUser.setValue(name.text, forAttribute:"Name")
    }
    if(!(age.text!.isEmpty))
    {
      currentUser.setValue(age.text, forAttribute: "Age")
    }
    
    if(!(city.text!.isEmpty))
    {
      currentUser.setValue(city.text, forAttribute:"City")
    }
    
    if(!(province.text!.isEmpty))
    {
      currentUser.setValue(province.text, forAttribute: "Province")
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
        self.delegateObject?.didFinishUpdate()
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