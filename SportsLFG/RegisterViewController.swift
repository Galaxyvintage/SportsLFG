// 
// File   : RegisterViewController.swift
// Author : Charles Li
// Date created: Oct.20 2015
// Date edited : Oct.31 2015
// Description:

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
  
  
  // MARK: Properties
  
 
  @IBOutlet weak var userNewEmail : UITextField!
  @IBOutlet weak var userNewPassword: UITextField!
  @IBOutlet weak var userNewPasswordConfirm: UITextField!
  
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
   
  
  func isValidEmail(testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
  }

  
  // MARK: Actions
  
  @IBAction func reigsterNewUser(sender: UIButton) {
  
    let email     = userNewEmail!.text          
    let password  = userNewPassword!.text
    let confirm   = userNewPasswordConfirm!.text
    
    // Check if password and confirm password match 
    if((password) != confirm)
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error", comment: "account success note title"),
        message: NSLocalizedString("Passwords do not match", comment: "password errors"),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
    
    // Check if there is any empty field
    if(email!.isEmpty    == true || 
       password!.isEmpty == true ||
       confirm!.isEmpty  == true )
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error", comment: "account success note title"),
        message: NSLocalizedString("Empty field", comment: "password errors"),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }  
    
    // Validate email format
    if(!(isValidEmail(email!)))
    {
      let alert = UIAlertController(
        title:   NSLocalizedString("Error", comment: "erro title "),
        message: NSLocalizedString("it's not a valid email address", comment: "email error"),
        preferredStyle : UIAlertControllerStyle.Alert
      )
      
      let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
      alert.addAction(cancelAction)
      presentViewController(alert, animated: true , completion: nil)
      return
    }
      

    
    // Kinvey new user register 
    
    
    NSLog("check")
    NSLog(email!)
    NSLog(password!)
    
    KCSUser.userWithUsername(
      email!,
      password: password!,
      fieldsAndValues:[KCSUserAttributeEmail:email!],
      withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
        if errorOrNil == nil {
          //was successful!
          NSLog("successful")
          let alert = UIAlertController(
            title: NSLocalizedString("Account Creation Successful", comment: "account success note title"),
            message: NSLocalizedString("User created. Welcome!", comment: "account success message body"),
            preferredStyle: UIAlertControllerStyle.Alert
          )
          
          let defaultAction = UIAlertAction(title :"OK", style: UIAlertActionStyle.Default, handler: nil)
          alert.addAction(defaultAction)
          self.presentViewController(alert, animated: true , completion: nil)
          return
          
        
        } else {
          NSLog("error")
          //there was an error with the create
          errorOrNil.userInfo["Kinvey.ExecutedHooks"]
          let errorObject = errorOrNil.userInfo["Kinvey.ExecutedHooks"]
          print(errorObject)
          let message = errorOrNil.localizedDescription
          let alert = UIAlertController(
            title: NSLocalizedString("Create account failed", comment: "Create account failed"),
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
          )
          
          let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
          alert.addAction(cancelAction)
          self.presentViewController(alert, animated: true , completion: nil)
          return
          
        }
      }
    )
  }

  
}

