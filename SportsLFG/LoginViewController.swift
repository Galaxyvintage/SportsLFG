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
  
  @IBOutlet weak var userEmailField: UITextField!
  @IBOutlet weak var userPasswordField: UITextField!
  

   
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
  
  
  //MARK: Actions
  
  @IBAction func userLogin(sender: UIButton) {
    let email = userEmailField.text
    let password = userPasswordField.text
    let mainControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("HomeController")
    KCSUser.loginWithUsername(
      email!,
      password: password!,
      withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
        if errorOrNil == nil {
          //the log-in was successful and the user is now the active user and credentials saved
          //hide log-in view and show main app content

          self.presentViewController(mainControllerView!, animated: true, completion: {() -> Void in
            //query the email 
            //find user info
            //load user info
          
          })
          
        } else {
          //there was an error with the update save
          
        
          let message = "password incorrect"//need to include the case when  internet connection is not available.
          let alert = UIAlertController(
            title: NSLocalizedString("Log-in failed", comment: "can not log in"),
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert  
          )
          let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
          alert.addAction(cancelAction)
          self.presentViewController(alert, animated: true, completion: nil)
         }
      }
    )
  }
  
  
  
  
    
}