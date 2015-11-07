//
// File  : Group.swift
// Author: Aaron Cheung, Charles Li
// Date created  : Oct.30 2015
// Date edited   : Nov.05 2015
// Description :
//

import Foundation

class Groups : NSObject{
  
  
  var entityId  : String?
  var name: String? 
  var dateCreated: String?
  var startTime  : String?
  var startDate  : String?
  var sport  : String?
  var maxSize : String?
  var address: String?
  var city    : String?
  var province: String?
  var metadata: KCSMetadata? //Kinvey metadata, optional
  
  
  //This function provided by Kinvey API maps the variables above to the back-end database schema
  override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
    return [
      "entityId" : KCSEntityKeyId, //the required _id field
      "name"     : "name",         //this is also unique 
      "dateCreated": "dateCreated",
      "sport"    : "sport",
      "startTime": "time",
      "startDate": "date",
      "maxSize"  : "maxSize",
      "address"  : "address",
      "city"     : "city",
      "province" :"province",
      "metadata" : KCSEntityKeyMetadata
  ]
  }
}



