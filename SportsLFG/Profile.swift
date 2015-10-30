//
//  Profile.swift
//  SportsLFG
//
//  Created by Aaron Cheung on 2015-10-30.
//  Copyright (c) 2015 CMPT-GP03. All rights reserved.
//
//  Profile class handles user's personal profile

import Foundation

class Profile {
    var name: str
    var age: Int
    var isMale: Bool // gender boolean
    var userID: Int
    
    //var rating: Double
    //var achievementPoints: Int
    
    init(userID id: Int) {
        self.id = id
    }
    
    // Function to retrieve user account information based on given account number
    // Returns true if successful
    private func getInfo(id: Int) -> Bool {
        // do stuff
        // self.name = databasegetName()
        // something like that????
        return true
    }
    
    //private func databaseGetName(userID)
    
}
