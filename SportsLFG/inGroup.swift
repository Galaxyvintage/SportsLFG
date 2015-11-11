//
// File  : inGroup.swift
// Author: Aaron Cheung, Charles Li, Isaac Qiao
// Date created  : Oct.30 2015
// Date edited   : Nov.11 2015
// Description   : This class is used to map the properties correctly to the 
//                 inGroups collection in our Kinvey's database
// TODO: this is unfinished and will not be used in version 1.0
//

import Foundation


class inGroup : NSObject{
  
  var entityId : String?     // as unique Kinvey entity _id
  var userId   : String?          
  var groupName: String?
  var metadata : KCSMetadata? //Kinvey metadata, optional
  
  
  //This function provided by Kinvey API maps the variables above to the back-end database schema
  override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
    return [
      "entityId"      :  KCSEntityKeyId,   //the required _id field
      "userId"        : "user",         //the name
      "groupName"     : "group",      //the group name the user is in
      "metadata"      :  KCSEntityKeyMetadata
    ]
  }
  
}
