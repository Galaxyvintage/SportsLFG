//
// File  : Group.swift
// Author: Charles Li
// Date  : Oct.30 2015
// Description :
//

import Foundation



class Group 
{
  
  //? means the value can become nil in he future, so thatyou test for this 
  //! means the value should not  become nil in the future, but it needs to be nil initially
 
  var groupType  : SportsType!
  var groupID    : UInt
  var groupName  : String!
  //var teamLeader : Profile  
  //var sport      : Sports!
  //var members     : Array<Profile>?
  //var waitingQueue   : wQueue<Profile>?
  var groupSizeMax     : UInt
  var groupSizeCurrent : UInt
  var ageMax     : UInt?
  var ageMin     : UInt?
  var gender     : GenderType
  var description: String?
  var isTeam     : Bool
  
  
  //initializer(constructor)
 
  init(type    : SportsType,
       ID      : UInt,
       size    : UInt
        
      )
  {
    groupType = type
    groupID   = ID 
    groupSizeMax = size
    groupSizeCurrent = 0
    gender    = GenderType.Neutral    //Neutral means no gender restriction
    isTeam    = false
  }
  
  
  
  func getSizeMax() -> UInt 
  {
    
    return 0
  }
  
  func getSizeCurrent() -> UInt 
  {
    
    return 0
  }
  
  func getAgeLimit()->(UInt,UInt)//returns ageMmin and ageMax
  {
    
    return (0,0)
  }
  
  func getDescription() ->String
  {
    
    return "a"
  }
  
  func isFull() -> Bool
  {
    return true 
  }
  
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