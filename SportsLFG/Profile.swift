//
// File  : Login.swift
// Author: Aaron Cheung, Charles Li
// Date  : Oct 30 2015
// Description : 
//

import Foundation

//TODO:
//     1. implement the init function
//     2. verify user information using kinvey api 
//     3. if user information is correct, current view is push to the HomeView
//     4. if user information is incorrect, an alert will be shown to users 

class Profile 
{
  var userName: String
  var userAge: UInt
  var isMale : Bool // gender boolean
  var userID: UInt
    
  //var rating: Double
  //var achievementPoints: Int
    
  init(id: UInt, gender : Bool, name :String, age : UInt) 
  {
    userID   = id
    userName = name
    userAge  = age
    isMale   = gender
  }
    
  // Function to retrieve user account information based on given account number
  // Returns true if successful
  private func getInfo(id: Int) -> Bool 
  {
    // do stuff
    // self.name = databasegetName()
    // something like that????
    return true
  }
    
  //private func databaseGetName(userID)
    
}
