//
// File : LoginViewController.swift
// Author : Aaron Cheung, Charles Li
// Date created : Oct 30 2015
// Date modified: Nov 01 2015
// Description  : This class is used by the login view controller and handles user login requests

import UIKit


class LoginViewController : UIViewController, UITextFieldDelegate
{
  
  // MARK: Properties
  
  @IBOutlet weak var userEmailField: UITextField!
  @IBOutlet weak var userPasswordField: UITextField!
  

  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //set all the textfields's delegate to its view controller
    self.userEmailField.delegate    = self
    self.userPasswordField.delegate = self
    
  }
  
  //This method dismisses keyboard on return key press
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    textField.resignFirstResponder()
    self.view.endEditing(true)
    return false
  }
  
  //This method dismisses keyboard by touching to anywhere on the screen
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }

  
  //MARK: Actions
  
  //This is the login method from the Kinvey API
  @IBAction func userLogin(sender: UIButton) {
    let email = userEmailField.text
    let password = userPasswordField.text
    let firstControllerView=self.storyboard?.instantiateViewControllerWithIdentifier("FirstTimeUser")
    let mainControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("HomeController")
    
    KCSUser.loginWithUsername(
      email!,
      password: password!,
      withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
        if errorOrNil == nil {
          //the log-in was successful and the user is now the active user and credentials saved
          //hide log-in view and show main app content
          
          let defaults = NSUserDefaults.standardUserDefaults()
          let key      = email!
          let didRunBefore = defaults.boolForKey(key) 
          
          NSLog("check")
          
          if(didRunBefore == false)
            
          {
            NSLog("in")
            defaults.setObject(true , forKey: key)
            defaults.synchronize()
            
            //push to a new view where user can enter their info the first time they use the app
            self.presentViewController(firstControllerView!,animated:true, completion:nil)
          }else{
            
            self.presentViewController(mainControllerView!, animated: true, completion: nil)              
          }
      
        } else {
          //there was an error with the update save
          
        
          let message = "email or password incorrect"//need to include the case when  internet connection is not available.
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