//
//  Group.swift
//  SportsLFG
//
//  Created by IsaacQ on 2015-11-06.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation

class Group : NSObject{
    
    var entityId : String?
    var name: String  //as unique Kinvey entity _id
    var dateCreated: String
    var startTime  : String
    var startDate  : String
    var sport  : String
    var maxSize : String
    var address: String
    var city    : String
    var province: String
    var metadata: KCSMetadata? //Kinvey metadata, optional
    
    init(name: String, dateCreated: String, startTime  : String, startDate  : String, sport  : String, maxSize : String, address: String, city    : String, province: String) {
        // Initialize stored properties.
        self.name = name
        self.dateCreated = dateCreated
        self.startTime = startTime
        self.startDate = startDate
        self.sport = sport
        self.maxSize = maxSize
        self.address = address
        self.city = city
        self.province = province
        
        // Can adda a constrain here for checking the init function
        // Initialization should fail if there is no name or if the rating is negative.
        //if name.isEmpty || rating < 0 {return nil}
    }
    
    //This function provided by Kinvey API maps the variables above to the back-end database schema
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId,   //the required _id field
            "name"    : "name",        //the name
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