//
// File  : Group.swift
// Author: Aaron Cheung, Charles Li, Isaac Qiao
// Date created  : Oct.30 2015
// Date edited   : Nov.08 2015
// Description :
//
//
class Group : NSObject{
    
    var entityId : String?
    var name: String?           // as unique Kinvey entity _id
    var nameLowercase : String? // prevent groups with same names but varying upper and lower case letters
                                // e.g when group "TESTING001" exists, "Testing001" cannot be created
                                
    var owner : String?
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
            "entityId" : KCSEntityKeyId,   //the required _id field
            "name"     : "name",           //the name
            "nameLowercase" :"nameLowercase",
            "owner"    : "owner",
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
