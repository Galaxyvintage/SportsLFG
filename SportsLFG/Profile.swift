//
// File  : Login.swift
// Author: Aaron Cheung, Charles Li
// Date created  : Oct 30 2015
// Date modified : Nov 03 2015
// Description : 
//

import Foundation


//unless user changes information, then she doesnt need to load her info from the database more than one 

class Location
{
  var myCity : String
  var myProvince : String
  var myCountry  : String
  
  //initialize the location object
  init(city : String, province : String, country : String)
  {
    myCity = city
    myProvince = province
    myCountry  = country
  }
}

class Profile 
{
  var userEmail: String!
  var userAge  : UInt!
  var location : Location!
  var isMale : Bool! // gender boolean
  var rating : Double!
  var sports : Array<String>!
  var achievemenPoints : UInt!

}


