//
// File  : Login.swift
// Author: Aaron Cheung, Charles Li
// Date created  : Oct 30 2015
// Date modified : Nov 01 2015
// Description : 
//

import Foundation

//TODO:
//     1. Retrieve profile info from Kinvey
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
  var userEmail: String
  var userAge  : UInt!
  var location : Location!
  var isMale : Bool! // gender boolean
  var rating : Double!
  var sports : Array<Sports>!
  var achievemenPoints : UInt!
  
  //Initializer 
  init(email : String)       
  {
    userEmail = email
  }
  
  //Steps to retrieve user info
  //1. users use emails to login successfully
  //2. based on emails, we retrieve values for all attributes in profile table
  //3. update the values to a new profile object associated into the users
  
  //TODO: need to somehow store the user info so that users can check their record
  //      without internet connections 
    
  
  
    
}
