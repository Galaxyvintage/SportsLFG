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
        let mainControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("LocationViewNavigation")
        
        KCSUser.loginWithUsername(
            email!,
            password: password!,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    
                    
                    //this fetches user data from the database to determine
                    //whether it's the user's first time using the app
                    user.refreshFromServer({ (objectsOrNil:[AnyObject]!, errorOrNil : NSError!) -> Void in
                        if(errorOrNil != nil)
                        {
                            //error
                        }
                        else if(objectsOrNil != nil)
                        {
                            let currentUser = objectsOrNil[0] as! KCSUser
                            
                            let check = currentUser.getValueForAttribute("Name")
                            
                            //this checks whether the currentuser's name is empty or nil
                            if(check == nil || check! as! String == ""){
                                self.presentViewController(firstControllerView!,animated:true, completion:nil)
                            }
                            else
                            {
                                self.presentViewController(mainControllerView!, animated: true, completion: nil)
                            }
                            
                        }
                        
                    })
                    
                    
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