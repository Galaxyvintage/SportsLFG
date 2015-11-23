# SportsLFG
#####Note: 
1. Developed using XCode 7.1 and Swift 2.0 targeting iOS 9.1. Using lower versions of either one could result in errors

2. Run the .xcworkspace file instead of .xcodeproj file because Kinvey's APIs is included using cocoapod


####TODO
#####VERSION 1.0

- [x] 1.  AccountLogin(password reset will be implemented in version 2.0)
- [x] 2.  GroupFinding("show my groups" will be implemented in version 2.0)


#####VERSION 2.0

- [ ] 1.  Password Reset(ver3.0)
- [x] 2.  Profile Editing
- [x] 3.  Map View for Groups
- [x] 4.  Searching by Category
- [ ] 5.  Group Deletion(ver3.0)
- [x] 6.  Business Logics for Database Collections in Kinvey 
- [x] 7.  Taking Profile Pictures  


#####VERSION 3.0
- [ ] 1. Search Group by Current Location
- [ ] 2. HealthKit(Energy Drink Record)
- [ ] 3. MyGroup
- [ ] 4. Arbitrary sports in group creation
- [ ] 5. GroupMembers Info in Group View
- [ ] 6. HealthKit(Energy Drink Record)
- [ ] 7. Leaving/Deleting Group
- [ ] 8. Not loading groups in the past 
- [ ] 9. Password Reset


#####Current Overview
1. The features we have now in our Version 1 are 

  1) creating account(with PK = email address)

  2) editing initial profile(cannot edit in this version)

  3) createinh groups (can only creat football and pingpong)

  4) looking for groups(in group list which will show all groups in the database).

2. Features we do not have in Version 1 are 

  1) changing your account password
  
  2) editing your profile in your profile page

  3) showing groups by categories 

  4) group map view

  5) team view(show your current team info)

  6) schedule view(show schedule of your groups)

  7) and More view(e.g. healthkit related)

3. Features we will have in Version 2 are fullfilling what we should do in V1 and also viewing groups in Map view (shows groups near you), checking your team, and HealthKit related functions .

