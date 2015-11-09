// 
// File   : HomeViewController.swift
// Author : Charles Li
// Date created: Oct.13 2015
// Date edited : Nov.03 2015
// Description: This is responsible for the home view controller and further functions need to be added in version 2.0

import Foundation

class HomeViewController : UIViewController
{
  
  @IBAction func Logout(sender: UIButton) {
    //let LoginControllerView=self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigationController")
    KCSUser.activeUser().logout()
    performSegueWithIdentifier("GoBackToLogin", sender: UIButton.self)    
  }
  override func viewDidLoad() {
        super.viewDidLoad()
  }
}