//
//  EditProfileController.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-15.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation

class EditProfileController : UIViewController
{

  @IBOutlet weak var name: UITextField!
  @IBOutlet weak var age:  UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var province: UITextField!
  
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
  
  
  @IBAction func SaveAndBack(sender: UIButton) {
    
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
    
    self.BackToHome()
  }  
}