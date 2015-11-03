//
// File : LoginViewController.swift
// Author : Aaron Cheung, Charles Li
// Date created : Oct 30 2015
// Date modified: Nov 01 2015
// Description :

import UIKit

//TODO:
//    1.If it's users' first time running the app, an information collecting view should 
//    be presented to the users

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