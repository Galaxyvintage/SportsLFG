//
//  Member.swift
//  SportsLFG
//
//  Created by Isaac Qiao on 2015-11-30.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation

class Member : NSObject{
    // MARK: Properties

    var photo : UIImage?
    var name : String?
    var age : String?
    var gender : String?
    var location : String?
    
    // MARK: Initialization
    
    init?(photo: UIImage?, name: String, age: String, gender: String, location: String) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.age = age
        self.gender = gender
        self.location = location
        
    }

}
