//
// File : LoginViewController.swift
// Author : Aaron Cheung, Charles Li
// Date created : Oct 30 2015
// Date modified: Nov 01 2015
// Description :

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