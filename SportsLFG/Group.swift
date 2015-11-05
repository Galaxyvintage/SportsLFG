//
// File  : Group.swift
// Author: Aaron Cheung, Charles Li
// Date created  : Oct.30 2015
// Date edited   : Nov.03 2015
// Description :
//

import Foundation



class Group 
{
  
  //? means the value can become nil in he future, so thatyou test for this 
  //! means the value should not  become nil in the future, but it needs to be nil initially
 
  var groupType  : SportsType!
  var groupID    : UInt
  var groupName  : String
  var teamLeader : Profile? 
  var sport      : String!
  var members          : Array<Profile>?
  var waitingQueue     : Queue<Profile>?
  var groupSizeMax     : UInt
  var groupSizeCurrent : UInt
  var ageMax     : UInt?
  var ageMin     : UInt?
  var gender     : GenderType?
  var description: String?
  var isTeam     : Bool
  
  
  //initializer(constructor)
 
  init(name    : String,
       type    : SportsType,
       ID      : UInt,
       size    : UInt)
  {
    groupType = type
    groupID   = ID 
    groupName = name
    groupSizeMax = size
    groupSizeCurrent = 0
    gender    = GenderType.Neutral    //Neutral means no gender restriction
    isTeam    = false
  }
  
  
  //This method returns the max size of a group
  func getSizeMax() -> UInt 
  {
    return groupSizeMax
  }
  
  //This method returns the current size of a group
  func getSizeCurrent() -> UInt 
  {
    
    return groupSizeCurrent
  }
  
  //This method returns the age limit of a group (minAge, maxAge)
  func getAgeLimit()->(UInt,UInt)
  {
    
    return (0,0)
  }
  
  //This method returns the description of a group 
  func getDescription() ->String
  {
    if ((description?.isEmpty) == nil) {
      return " "
    } else {
      return description!
    }
  }
  
  //This method returns true if the group is full and false if the group still has spots
  func isFull() -> Bool
  {
    if groupSizeCurrent >= groupSizeMax {
      return true
    }
    return false 
  }
  
  //This method returns true if the user is the leader of the group and false otherwise
  func isLeader(userID : UInt) -> Bool
  {
    return true
  }
  
  
  /*
  the following 3 methods can only be implemented after the profile class are created in
  the login system
  
  func checkRequest() -> wQueue<Profile>
  {
    
    
  }
  
  func acceptRequest(profile : Profile) -> void
  {
  
  }
  
  func rejectRequest(profile : Profile) ->void
  {
  
  }
  */
  
    
}
