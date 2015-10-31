//
// File  : Login.swift
// Author: Aaron Cheung, Charles Li
// Date  : Oct 30 2015
// Description : 
//

import Foundation

//TODO:
//     1. implement the init function
class Location
{
  var myCity : String
  var myProvince : String
  var myCountry  : String
  init(city : String, province : String, country : String)
  {
    myCity = city
    myProvince = province
    myCountry  = country
  }
}


class Profile 
{
  var userName : String!
  var userEmai : String!
  var userAge  : UInt!
  var location : Location!
  var isMale : Bool! // gender boolean
  var userID : UInt!
  var rating : Double!
  var sports : Array<Sports>!
  var achievemenPoints : UInt!
    
  init()
  {
    
    
  }
    
  
  private func getInfo(userID : UInt) -> Bool 
  {
    // do stuff
    // self.name = databasegetName()
    // something like that????
    return true
  }
  
  //private func databaseGetName(userID)

  //func 
  
    
}
