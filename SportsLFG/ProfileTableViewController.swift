//
// File : ProfileTableViewController.swift
// Author :Charles Li
// Date created : Nov 03 2015
// Date modified: Nov 20 2015
// Description : This is class is used to handle personal information

import Foundation

class ProfileTableViewController : UITableViewController
{
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var age: UILabel!
  @IBOutlet weak var location: UILabel!
  @IBOutlet weak var gender: UILabel!

  override func viewDidLoad() {
    
    //change the label accordingly to the user info given by the KCSUser object
  
    let currentUser = KCSUser.activeUser()
    let myName      = currentUser.getValueForAttribute("Name") as! String
    let myAge       = (currentUser.getValueForAttribute("Age") as! String)+" years old"
    let myLocation  = (currentUser.getValueForAttribute("City") as! String)+", "+(currentUser.getValueForAttribute("Province") as! String)
    let myGender    = currentUser.getValueForAttribute("Gender") as! String
    
    name.text = myName
    age.text =  myAge
    location.text = myLocation
    gender.text   = myGender
     
  }
}