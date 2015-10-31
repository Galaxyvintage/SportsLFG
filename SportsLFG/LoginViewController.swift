//
//  Log-in.swift
//  SportsLFG
//
//  Created by Aaron Cheung on 2015-10-30.
//  Copyright (c) 2015 CMPT-GP03. All rights reserved.
//

import UIKit

//TODO:
//     1. verify user information using kinvey api 
//     2. if user information is correct, current view is push to the HomeView
//     3. if user information is incorrect, an alert will be shown to users 
//
//
class LoginViewController : UIViewController, UITextFieldDelegate
{
  
  // MARK: Properties
  
  var userID : UInt?
  var userEmail : String?
  // Function to retrieve user account information based on given account number
  // Returns true if successful
  
  
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    self.view.endEditing(true)
    return false
  }
  
  
    
}