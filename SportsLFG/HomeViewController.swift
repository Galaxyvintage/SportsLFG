// 
// File   : HomeViewController.swift
// Author : Charles Li
// Date created: Oct.13 2015
// Date edited : Nov.03 2015
// Description:

import Foundation

class HomeViewController : UIViewController
{
  
  @IBAction func Logout(sender: UIButton) {
    let LoginControllerView=self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigationController")
    KCSUser.activeUser().logout()
    self.presentViewController(LoginControllerView!, animated: true, completion: nil)
    
  }
  override func viewDidLoad() {
        super.viewDidLoad()
  }
}