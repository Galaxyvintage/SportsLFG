//
//  GroupTableViewController_2.swift
//  SportsLFG
//
//  Created by Charles Li on 2015-11-27.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit

class GroupTableViewController_2: UITableViewController, UITextFieldDelegate
{
  
  internal var selectedIndexPath:NSIndexPath? = nil
  
  var sectionZero = ["Group Name"]
  var sectionOne  = ["Sport",
    "Group Size",
    "Start",
    "End",
    "Restrictions",]
  var sectionTwo = ["Location","Note"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  ////////////////////
  //Delegate methods//
  ////////////////////
  
  
  override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
  
  
  
  
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    return 3
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section{
      
    case 0: return 1
      
    case 1: return sectionOne.count
      
    case 2: return sectionTwo.count
      
    default:return sectionZero.count
    }
  }
  
  //Load different table view cell based on the section and row
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cellIdentifier : String
    
    //load the corresponding table view cell based on the current selected cell
    if(selectedIndexPath != nil)
    {
      
     
      switch (selectedIndexPath!.section, selectedIndexPath!.row)
      {
        
      case(1,0)://Sport
        if(indexPath.section == 1 && indexPath.row == 1)
        {
          cellIdentifier = "SportsSelectionCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SportsSelectionTableViewCell
          return Cell
        }
        
      case (1,1)://GroupSize
        if(indexPath.section == 1 && indexPath.row == 2)
        {
          cellIdentifier = "TextInputCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextInputTableViewCell
          return Cell
        }
      case(1,2)://Start Date Picker
        if(indexPath.section == 1 && indexPath.row == 3)
        {
           let currentSelectedCell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TitleTableViewCell
          
          cellIdentifier = "DatePickerCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DatePickerTableViewCell
          
          Cell.delegateObject = currentSelectedCell
          Cell.currentState   = "startDate"
          
          //configure the date picker
          
          // Initial values for time and date
          let currentDate = NSDate()
          
          Cell.datePicker.minimumDate    = currentDate
          Cell.datePicker.minuteInterval = 5
          
          Cell.dateFormatter = NSDateFormatter()
          Cell.dateFormatter?.dateStyle = NSDateFormatterStyle.ShortStyle
          Cell.dateFormatter?.timeStyle = NSDateFormatterStyle.ShortStyle
          
          //update the currentSelected right label to the current time of the system
          currentSelectedCell.rightLabel.text = Cell.dateFormatter?.stringFromDate(currentDate)
          currentSelectedCell.rightLabel.textColor = UIColor.blackColor()
          
                    
          return Cell
        }
      case(1,3)://End Date Picker
        if(indexPath.section == 1 && indexPath.row == 4)
        {
          cellIdentifier = "DatePickerCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DatePickerTableViewCell
          
          Cell.currentState   = "endDate"
    
          
          
          
          return Cell
        }
      case (1,4)://Restrictions
        if(indexPath.section == 1 && indexPath.row == 5)
        {
          cellIdentifier = "TextInputCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextInputTableViewCell
          return Cell
        }
      case(2,0)://Location
        if(indexPath.section == 2 && indexPath.row == 1)
        {
          cellIdentifier = "LocationInputCell"
          let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LocationTableViewCell
          return Cell
        }
      default: break
      }
    }
    
    //This is for group name input cell, in which it doesn't have a expansion
    if(indexPath.section == 0 && indexPath.row == 0)
    {
      
      cellIdentifier = "GroupNameInputCell"
      let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextInputTableViewCell
      
      return Cell
    }
      
      //This is for note input cell, in which it doesn't have a expansion
    else if((indexPath.section == 2 && indexPath.row == 1 ) ||
      (indexPath.section == 2 && indexPath.row == 2)   ) // index becomes (2,2) when location cell is expanded
    {
      
      cellIdentifier = "NoteInputCell"
      let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! NotetableViewCell
      
      return Cell
      
    }
    else
    {
      cellIdentifier = "GroupDetailCell"
      let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TitleTableViewCell
      
      // Configure the title cell...
      var title : String
      switch indexPath.section{
        
        // first section
      case 0:  title = sectionZero[indexPath.row]
        // seoncd section
      case 1:  title = sectionOne [indexPath.row]
        // third section
      case 2:  title = sectionTwo [indexPath.row]
        
      default: title = sectionZero[indexPath.row]
      }
      
      Cell.titleLabel.text = title
      // rounded corners
      return Cell
    }
  }
  
  //didSelect
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    print("did select....")
    // in fact, was this very row selected,
    // and the user is clicking to deselect it...
    // if you don't want "click a selected row to deselect"
    // then on't include this clause.
    if(selectedIndexPath == indexPath)
    {
      
      //REMOVE
      print("(user clicked on selected to deselect)")
      selectedIndexPath = nil
      var indexPathToRemove : NSIndexPath
      
      tableView.deselectRowAtIndexPath(indexPath, animated:false)
      switch (indexPath.section, indexPath.row)
      {
      case (0,0):
        self.sectionZero.removeAtIndex(1)  // update the data source
        return
        
      case(1,0):
        self.sectionOne.removeAtIndex(1)
        indexPathToRemove = NSIndexPath(forRow: 1, inSection: 1)
        
      case(1,1):
        self.sectionOne.removeAtIndex(2)
        indexPathToRemove = NSIndexPath(forRow: 2, inSection: 1)
        
      case(1,2):
        self.sectionOne.removeAtIndex(3)
        indexPathToRemove = NSIndexPath(forRow: 3, inSection: 1)
        
      case(1,3):
        self.sectionOne.removeAtIndex(4)
        indexPathToRemove = NSIndexPath(forRow: 4, inSection: 1)
        
      case(1,4):
        self.sectionOne.removeAtIndex(5)
        indexPathToRemove = NSIndexPath(forRow: 5, inSection: 1)
        
      case(2,0):
        self.sectionTwo.removeAtIndex(1)
        indexPathToRemove = NSIndexPath(forRow: 1, inSection: 2)
        
      case(2,1):
        self.sectionTwo.removeAtIndex(2)
        return
      default: return
      }
      NSLog("removing")
      print(indexPathToRemove)
      self.tableView.beginUpdates()
      self.tableView.deleteRowsAtIndexPaths(NSArray(object:indexPathToRemove) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
      self.tableView.endUpdates()
      
      self.tableView.endEditing(true)
      
      return
    }
    
    
    let currentSection = indexPath.section
    var currentRow = indexPath.row
    
    //something else is selected
    if(selectedIndexPath != nil)
    {
      let selectedRow = selectedIndexPath!.row
      var indexPathToRemove : NSIndexPath?
      if(currentSection == selectedIndexPath!.section &&
        currentRow > selectedIndexPath!.row)
      {
        currentRow = currentRow - 1
      }
      
      tableView.deselectRowAtIndexPath(selectedIndexPath!, animated:false)
      
      switch selectedIndexPath!.section
      {
      case 0 :
        self.sectionZero.removeAtIndex(selectedRow + 1)
        break
      case 1 :
        self.sectionOne.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 1)
      case 2:
        self.sectionTwo.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        
        if(selectedRow != 1) //Not NoteInputCell
        {
          indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 2)
        }
      default: break
      }
      
      if(indexPathToRemove != nil)
      {
        self.tableView.beginUpdates()
        NSLog("removing")
        self.tableView.deleteRowsAtIndexPaths(NSArray(object: indexPathToRemove!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.endUpdates()
        
        self.tableView.endEditing(true)
      }
    }
    
    // no previous selection
    selectedIndexPath = NSIndexPath(forRow: currentRow, inSection: currentSection)
    
    var indexPathToInsert : NSIndexPath
    
    // update the data source
    switch (currentSection, currentRow) {
      
    case(0,0):
      self.sectionZero.append("GroupNameInput");
      return
    case(1,0):
      self.sectionOne.insert("SportsSelection", atIndex: 1)
      
    case(1,1):
      self.sectionOne.insert("GroupSizeInput", atIndex: 2);
      print(sectionOne)
    case(1,2):
      self.sectionOne.insert("StartDateSelection", atIndex: 3)
      print(sectionOne)
    case(1,3):
      self.sectionOne.insert("EndDateSelection", atIndex: 4)
      print(sectionOne)
    case(1,4):
      self.sectionOne.insert("RestrictionInput", atIndex: 5)
      print(sectionOne)
    case(2,0):
      self.sectionTwo.insert("LocationInput",atIndex:1)
      print("Inserted location input")
      print(sectionTwo)
      
    case(2,1):
      self.sectionTwo.insert("NoteInput",atIndex:2)
      print(sectionTwo)
      return
      
    default: return
      
    }
    
    indexPathToInsert = NSIndexPath(forRow: currentRow + 1, inSection: currentSection)
    
    self.tableView.beginUpdates()
    self.tableView.insertRowsAtIndexPaths(NSArray(object: indexPathToInsert) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    self.tableView.endUpdates()
    
    self.tableView.endEditing(true)
    
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    //if any cell is selected
    if let selected = selectedIndexPath
    {
      switch(selected.section,selected.row)
      {
      case(1,0): //Sport
        //only update the height of the row at section 1 row 1
        if(indexPath.section == 1 &&
          indexPath.row    == 1 &&
          sectionOne[1]    == "SportsSelection")
        {
          return CGFloat(138)
        }
        
      case(1,2): //Start time
        
        if(indexPath.section == 1 &&
          indexPath.row    == 3 &&
          sectionOne[3]    == "StartDateSelection")
        {
          return CGFloat(150)
        }
        
      case(1,3)://End time
        if(indexPath.section == 1 &&
          indexPath.row    == 4 &&
          sectionOne[4]    == "EndDateSelection")
        {
          return CGFloat(150)
        }
        
      case(2,0):
        if(indexPath.section == 2 &&
          indexPath.row    == 1 &&
          sectionTwo[1]    == "LocationInput")
        {
          return CGFloat(296)
        }
          
        else if((indexPath.section == 2 && indexPath.row == 1 ) ||
          (indexPath.section == 2 && indexPath.row == 2)   )
          
        {
          return CGFloat(120)
        }
        
      default : break
      }
      
      return CGFloat(48)
    }
      
    else if((indexPath.section == 2 && indexPath.row == 1 ) ||
      (indexPath.section == 2 && indexPath.row == 2)   )
      
    {
      return CGFloat(120)
    }
    else
    {
      return CGFloat(48)
    }
  }
  
  //This method adds a header between two sections
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  {
    let spacing = CGFloat(15)
    return spacing
  }
  
  //This method defines what each header of each section should look like
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clearColor()
    return headerView
  }
  
}
