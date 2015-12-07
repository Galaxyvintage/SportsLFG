//
//  EnergyTableViewController .swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-29.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation
import UIKit


class EnergyTableViewController : UITableViewController,SavingHKSamplesDelegate
{
  
  internal var selectedIndexPath:NSIndexPath? = nil
  
  let kAuthorizeHealthKitSection = 1
  
  var sectionZero = ["Water","Gatorade"] 
  let sectionOne  = ["Authorize HealthKit"]
  
  let healthManager : HealthManager = HealthManager()
  
  func authorizeHealthKit()
  {
    print("TODO: Request HealthKit Authorization")
    
    healthManager.authorizeHealthKit{(authorized, error) -> Void in
      if authorized
      {
        print("HealthKit authorization received")
        let alert = UIAlertController(
          title: "Hello",
          message: "This app has been linked to health app. Please go to the health app and change the settings under the Sources tab if needed",
          preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(
          title: "OK", 
          style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        
        dispatch_sync(dispatch_get_main_queue()) {
          // Do UI stuff here
          self.presentViewController(alert, animated: true, completion: nil) 
        }
        
      }
      else
      {
        print("HealthKit authorization denied!")
        if( error != nil)
        {
          print("\(error)")
        }
      }
    }  
  }
  
  func didFinishLoadingHKSamplesDelegate()
  {
    let indexPathToSelect = NSIndexPath(forRow: 1, inSection: 0)
    self.tableView.selectRowAtIndexPath(indexPathToSelect, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    self.tableView(self.tableView, didSelectRowAtIndexPath:indexPathToSelect)
    let alert = UIAlertController(
        title: "Hello",
        message: "The data should be saved if health app has been authorized ",
        preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(
        title: "OK",
        style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(okAction)

    
    self.presentViewController(alert, animated: true, completion: nil)

    NSLog("Finish Loading HKSamples")
  }
  
  // MARK: - TableView Delegate
  
  override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.view.endEditing(true)
  }

     
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
    
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section
    {
    case 0 : return sectionZero.count
    case 1 : return sectionOne.count
    default: return 0
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var title : String?
    var cellIdentifier : String
    if(selectedIndexPath != nil)
    {
      switch (selectedIndexPath!.section, selectedIndexPath!.row) 
      {
        
      case (0,0)://(section: 0, row : 1) 
        cellIdentifier = "WaterCell"
        let Cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WaterTableViewCell
        return Cell
        
      case(0,1)://TODO: Need to change this 
        cellIdentifier = "G2GatoradeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! G2GatoradeTableViewCell
        
        let G2GatoradeObject = G2Gatorade()
    
        cell.Calories.text  = String(G2GatoradeObject.Calories)
        cell.Sodium.text    = String(G2GatoradeObject.Sodium)
        cell.Potassium.text = String(G2GatoradeObject.Potassium)
        cell.Sugars.text    = String(G2GatoradeObject.Sugars)
        
        cell.bottlesConsumed.text = "1"
        
        cell.healthManager  = self.healthManager
        cell.delegateObject = self
        
        return cell
      default: break
      }
      
    }  
    switch indexPath.section{
      
      // first section
    case 0:  
      title = sectionZero[indexPath.row]
      let cellIdentifier = "TitleCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EnergyTableViewCell
      cell.TitleLabel.text = title    
      
      return cell
      // seoncd section
    default:  
      let cellIdentifier = "HealthKitCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) 
      return cell
      
    }
  }
  
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) 
  {
    
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
        indexPathToRemove = NSIndexPath(forRow: 1, inSection: 0)
      case (0,1): 
        self.sectionZero.removeAtIndex(2)  // update the data source    
        indexPathToRemove = NSIndexPath(forRow: 2, inSection: 0) 
        
      default: return      
      }
      NSLog("removing")
      print(indexPathToRemove)
      self.tableView.beginUpdates()
      self.tableView.deleteRowsAtIndexPaths(NSArray(object:indexPathToRemove) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
      self.tableView.endUpdates()
      return
    }
    
  
    let currentSection = indexPath.section
    var currentRow = indexPath.row
    
    
    //something else is selected 
    if(selectedIndexPath != nil)
    {
      let selectedRow = selectedIndexPath!.row
      var indexPathToRemove : NSIndexPath
      if(currentSection == selectedIndexPath!.section &&
        currentRow > selectedIndexPath!.row)
      {
        currentRow = currentRow - 1 //there is an extra row above the current selected 
                                    //that is about to be removed 
      }
      
      tableView.deselectRowAtIndexPath(selectedIndexPath!, animated:false)
      
      switch selectedIndexPath!.section
      {
      case 0 :
        self.sectionZero.removeAtIndex(selectedRow + 1)
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 0)
        
        self.tableView.beginUpdates()
        NSLog("removing")
        self.tableView.deleteRowsAtIndexPaths(NSArray(object: indexPathToRemove) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.endUpdates()
        
      case 1 : break   
        
      default:
        return
      } 
      
    }
    
    
    // no previous selection
    selectedIndexPath = NSIndexPath(forRow: currentRow, inSection: currentSection)
    
    var indexPathToInsert : NSIndexPath
    
    switch(currentSection, currentRow)
    {
    case(kAuthorizeHealthKitSection,0):
      authorizeHealthKit()
      self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
      return
      
      //Water 
    case(0,0):
      self.sectionZero.insert("WaterDataInput", atIndex: 1)
      indexPathToInsert = NSIndexPath(forRow: 1, inSection: 0)
      print(self.sectionZero)
    case(0,1):
      self.sectionZero.insert("G2GatoradeInput", atIndex: 2)//TODO:Need to change the string
      indexPathToInsert = NSIndexPath(forRow: 2, inSection: 0)
      print(self.sectionZero)
    default:return
      
    }
    self.tableView.beginUpdates()
    self.tableView.insertRowsAtIndexPaths(NSArray(object: indexPathToInsert) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    self.tableView.endUpdates()
  }
  
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    //if any cell is selected  
    if let selected = selectedIndexPath
    {
      switch(selected.section,selected.row)
      {
      case(0,0):
        if(indexPath.section   == 0 && 
           indexPath.row       == 1 &&
           self.sectionZero[1] == "WaterDataInput")
        {
          return CGFloat(157)
        }
      case(0,1):  
        if(indexPath.section   == 0 && 
           indexPath.row       == 2 &&
           self.sectionZero[2] == "G2GatoradeInput")//TODO:Update the string
        {
          return CGFloat(329)
        }

        
      default : return CGFloat(48)  
      }
    }  
    return CGFloat(48)
  }
  
  
  //MARK: Actions
  
  @IBAction func Back(sender: AnyObject) {
    
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
}