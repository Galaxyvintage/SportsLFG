//
//  GroupTableViewController_2.swift
//  SportsLFG
//
//  Created by Charles Li on 2015-11-27.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GroupTableViewController_2: UITableViewController, UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
  
  internal var selectedIndexPath:NSIndexPath? = nil
  
  var sectionZero = ["Group Name"]
  var sectionOne  = ["Sport",
    "Group Size",
    "Start",
    "End",
    "Restrictions",]
  var sectionTwo = ["Location","Note"]
  
  var dictOne :[Int:String]  = [:]//sport,size,start time, end time,restriction
  
  weak var mapView : MKMapView?
  
  var geocoder        : CLGeocoder?
  
  var locationManager : CLLocationManager?
  
  var myCurrentLocation : CLLocation?
  
  var address : String?
  var city    : String?
  var province: String?
  var isLocationValid : Bool?
  
  var groupName : String?
  var categoryArr = ["Outdoor","Indoor","Gym"]
  var category : String?
  var sport    : String?
  var size     : String?
  var time     : String?
  var date     : String?
  var note     : String?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for i in 0...4
    {
      self.dictOne[i] = "Unknown"
    }
    self.tableView.delegate = self
    self.geocoder        = CLGeocoder()
    self.locationManager = CLLocationManager()
    self.locationManager!.delegate = self
    self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
    
    self.note = "Come Join In!"
    
    
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
  
  
  //MARK: CLLocationManager Delegate
  
  //The following two methods are delegate methods for setting up the location manager and map view
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location = locations.last
    
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    self.mapView!.setRegion(region, animated: true)
    
    self.locationManager!.stopUpdatingLocation()
  }
  
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
  {
    print("Error: " + error.localizedDescription)
  }
  
  // MARK: TextField Delegates
  
  override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
  
  //This delegate methods handles deselection when a text field is selected
  func textFieldDidBeginEditing(textField: UITextField) {
    if(textField.tag == 0 )//GroupName
    {
      let containerCell = (textField.superview?.superview) as! TextInputTableViewCell
      var currentIndexPath : NSIndexPath?
      
      if let selectedCell  = containerCell.parentCell
      {
        currentIndexPath     = self.tableView.indexPathForCell(selectedCell)
      }
      //something else is currentlyselected
      if(selectedIndexPath != nil &&
        selectedIndexPath != currentIndexPath)
      {
        let selectedRow = selectedIndexPath!.row
        var indexPathToRemove : NSIndexPath?
        
        self.tableView.deselectRowAtIndexPath(selectedIndexPath!, animated:false)
        
        switch selectedIndexPath!.section
        {
        case 0 :
          //self.sectionZero.removeAtIndex(selectedRow + 1)
          break
        case 1 :
          self.sectionOne.removeAtIndex(selectedRow  + 1) //content shown 1 row below
          indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 1)
        case 2:
          self.sectionTwo.removeAtIndex(selectedRow  + 1) //content shown 1 row below
          indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 2)
          
        default: break
        }
        
        if(indexPathToRemove != nil)
        {
          self.tableView.beginUpdates()
          NSLog("removing")
          self.tableView.deleteRowsAtIndexPaths(NSArray(object: indexPathToRemove!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
          self.tableView.endUpdates()
        }
        selectedIndexPath = nil
      }
    }
  }
  
  //This delegate method sets the text in the text field to the label in
  //its parent cell, which is a reference to the title cell above
  func textFieldDidEndEditing(textField: UITextField) {
    
    if(textField.tag == 0)
    {
      if(textField.text == nil || (textField.text!).isEmpty)
      {
        return
      }
      else
      {
        self.groupName = textField.text
      }
    }
      
      
    else if( textField.tag == 1 )//TextField in sport selection
    {
      let containerCell = (textField.superview?.superview) as! SportsSelectionTableViewCell
      if(textField.text == nil || (textField.text!).isEmpty)
      {
        containerCell.parentCell!.rightLabel.text = "Unknown"
        containerCell.parentCell!.rightLabel.textColor = UIColor.grayColor()
      }
      else
      {
        self.sport = textField.text
        self.dictOne[0] = textField.text
        containerCell.parentCell!.rightLabel.text = textField.text
        containerCell.parentCell!.rightLabel.textColor = UIColor.blackColor()
      }
    }
      
    else if(textField.tag == 2)//if it's size input text field
    {
      
      let containerCell = (textField.superview?.superview) as? TextInputTableViewCell
      self.size = textField.text
      self.dictOne[1] = textField.text
      if(textField.text == nil || (textField.text!).isEmpty)
      {
        containerCell!.parentCell!.rightLabel.text = "Unknown"
        containerCell!.parentCell!.rightLabel.textColor = UIColor.grayColor()
      }
      else
      {
        containerCell!.parentCell!.rightLabel.text = textField.text
        containerCell!.parentCell!.rightLabel.textColor = UIColor.blackColor()
        
      }
    }
    else if(textField.tag == 3)//address
    {
      self.address = textField.text
    }
    else if(textField.tag == 4)//city
    {
      self.city = textField.text
    }
    else if(textField.tag == 5)//province
    {
      self.province = textField.text
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    return true
  }
  
  
  //Mark: TextView Delegates
  
  //This delegate methods handles deselection when a text field is selected
  func textViewDidBeginEditing(textView: UITextView) {
    //something else is selected
    print(sectionOne)
    if(selectedIndexPath != nil)
    {
      let selectedRow = selectedIndexPath!.row
      var indexPathToRemove : NSIndexPath?
      
      self.tableView.deselectRowAtIndexPath(selectedIndexPath!, animated:false)
      
      switch selectedIndexPath!.section
      {
      case 0 :
        //self.sectionZero.removeAtIndex(selectedRow + 1)
        break
      case 1 :
        self.sectionOne.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 1)
      case 2:
        self.sectionTwo.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 2)
        
      default: break
      }
      
      if(indexPathToRemove != nil)
      {
        self.tableView.beginUpdates()
        NSLog("removing")
        self.tableView.deleteRowsAtIndexPaths(NSArray(object: indexPathToRemove!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
        self.tableView.endUpdates()
      }
      selectedIndexPath = nil
    }
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    textView.text = self.note
  }
  
  //MARK: PickerView Delegates
  
  
  //This method is used to specify the number of cloumns in the picker elemnt
  func numberOfComponentsInPickerView(pickerView :UIPickerView) -> Int
  {
    return 1
  }
  
  //This method is used to specify the number of rows of data in the UIPickerView element
  func pickerView(pickerView : UIPickerView, numberOfRowsInComponent component: Int)->Int
  {
    return categoryArr.count
  }
  
  //This method is used to specify the data for a specific row and specific component
  func pickerView(pickerView : UIPickerView, titleForRow row :Int, forComponent component: Int) -> String?
  {
    return categoryArr[row]
  }
  
  
  func pickerView(pickerView : UIPickerView, didSelectRow row : Int, inComponent component : Int)
  {
    category = categoryArr[row]
  }
  
  // MARK: Table view data source
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
        
        let currentSelectedCell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TitleTableViewCell
        
        if(indexPath.section == 1 && indexPath.row == 1)
        {
          cellIdentifier = "SportsSelectionCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SportsSelectionTableViewCell
          
          cell.parentCell = currentSelectedCell
          cell.parentController = self
          cell.userInput.delegate     = self
          cell.userInput.placeholder = "Enter your own sport"
          cell.categoryPicker.delegate = self
          
          if(self.category == nil)
          {
            cell.categoryPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(cell.categoryPicker, didSelectRow: 0, inComponent: 0)
          }
          else
          {
            let index = categoryArr.indexOf(self.category!)
            cell.categoryPicker.selectRow(index!, inComponent: 0, animated: true)
            self.pickerView(cell.categoryPicker, didSelectRow: index!, inComponent: 0)
          }
          print(self.category)
          return cell
        }
      case (1,1)://GroupSize
        
        let currentSelectedCell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TitleTableViewCell
        
        if(indexPath.section == 1 && indexPath.row == 2)
        {
          cellIdentifier = "TextInputCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextInputTableViewCell
          
          cell.parentCell              = currentSelectedCell
          cell.inputField.keyboardType = UIKeyboardType.NumberPad
          cell.inputField.delegate     = self
          cell.inputField.placeholder  = "Enter your number here"
          
          if (currentSelectedCell.rightLabel.text != "Unknown")
          {
            currentSelectedCell.rightLabel.text = self.size
          }
          
          return cell
        }
      case(1,2)://Start Date Picker
        
        let currentSelectedCell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TitleTableViewCell
        
        if(indexPath.section == 1 && indexPath.row == 3)
        {
          cellIdentifier = "DatePickerCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DatePickerTableViewCell
          
          cell.parentCell = currentSelectedCell
          cell.parentController = self
          cell.currentState   = "startDate"
          
          // Initial values for time and date
          let currentDate = NSDate()
          
          cell.datePicker.minimumDate    = currentDate
          cell.datePicker.minuteInterval = 5
          
          cell.dateFormatter = NSDateFormatter()
          cell.timeFormatter = NSDateFormatter()
          
          cell.dateFormatter!.dateStyle = NSDateFormatterStyle.ShortStyle
          cell.dateFormatter!.dateFormat = "dd/MM/yy"
          
          cell.timeFormatter!.timeStyle = NSDateFormatterStyle.ShortStyle
          cell.timeFormatter!.dateFormat = "HH:mm"
          
          //update the currentSelected right label to the current time of the system
          if(cell.parentCell!.rightLabel.text == "Unknown")
          {
            
            let date = cell.dateFormatter!.stringFromDate(currentDate)
            let time = cell.timeFormatter!.stringFromDate(currentDate)
            
            self.date = date
            self.time = time
            
            cell.parentCell!.rightLabel.text = date + ", " + time
            cell.parentCell!.rightLabel.textColor = UIColor.blackColor()
            self.dictOne[2] = date + ", " + time
          }
          else
          {
            cell.parentCell!.rightLabel.text = self.date! + ", " + self.time!
          }
          return cell
        }
      case(1,3)://End Date Picker
        
        
        if(indexPath.section == 1 && indexPath.row == 4)
        {
          cellIdentifier = "DatePickerCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DatePickerTableViewCell
          
          cell.currentState   = "endDate"
          
          return cell
        }
      case (1,4)://Restrictions
        
        
        if(indexPath.section == 1 && indexPath.row == 5)
        {
          cellIdentifier = "RestrictionInputCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestrictionTableViewCell
          
          return cell
        }
      case(2,0)://Location
        
        let currentSelectedCell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TitleTableViewCell
        
        
        if(indexPath.section == 2 && indexPath.row == 1)
        {
          cellIdentifier = "LocationInputCell"
          let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LocationTableViewCell
          
          cell.parentCell = currentSelectedCell
          cell.parentController = self
          currentSelectedCell.rightLabel.text = ""
          
          //Configure the map view in this cell
          cell.geocoder   = self.geocoder
          cell.locationManager = self.locationManager
          self.mapView = cell.mapView
          
          cell.address.delegate  = self
          cell.city.delegate     = self
          cell.province.delegate = self
          
          if(self.address  != nil &&
            self.city      != nil &&
            self.province  != nil)
          {
            currentSelectedCell.rightLabel.textColor = UIColor.blackColor()
            cell.address.text  = self.address
            cell.province.text = self.city
            cell.province.text = self.province
          }
          
          self.locationManager!.requestWhenInUseAuthorization()
          
          self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
          
          self.locationManager!.startUpdatingLocation()
          
          if(locationManager!.location != nil)
          {
            self.myCurrentLocation = locationManager!.location
          }
          
          self.mapView!.showsUserLocation = true
          
          return cell
        }
      default: break
      }
      
    }
    //This is for group name input cell, in which it doesn't have an expansion
    if(indexPath.section == 0 && indexPath.row == 0)
    {
      
      cellIdentifier = "GroupNameInputCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextInputTableViewCell
      cell.inputField.delegate = self
      return cell
    }
      
      //This is for note input cell, in which it doesn't have an expansion
    else if((indexPath.section == 2 && indexPath.row == 1) ||
      (indexPath.section == 2 && indexPath.row == 2)  ) // index becomes (2,2) when location cell is expanded
    {
      
      cellIdentifier = "NoteInputCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! NotetableViewCell
      
      cell.noteContent.delegate = self
      cell.noteContent.text     = self.note
      
      return cell
      
    }
    else
    {
      cellIdentifier = "GroupDetailCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TitleTableViewCell
      
      // Configure the title cell...
      var title : String
      switch indexPath.section{
        
        // first section
        // case 0:  title = sectionZero[indexPath.row]
        // seoncd section
      case 1:
        title = sectionOne [indexPath.row]
        cell.rightLabel.text! = self.dictOne[indexPath.row]!
        
        if(self.dictOne[indexPath.row]! == "Unknown")
        {
          cell.rightLabel.textColor = UIColor.grayColor()
        }
        else
        {
          cell.rightLabel.textColor = UIColor.blackColor()
        }
        
        
        // third section
      case 2:
        title = sectionTwo [indexPath.row]
        cell.rightLabel.text = ""
        
        
      default: title = sectionZero[indexPath.row]
      }
      
      cell.titleLabel.text = title
      
      return cell
    }
    
  }
  
  //didSelect
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
    //Note:
    //case (0,0) and (2,1) are not included here since
    //the textfield/textview is blocking the cell and they
    //have to handle deselection separately in delegate methods
    
    print("did select....")
    //current selected row has been previously selected
    if(selectedIndexPath == indexPath)
    {
      
      //REMOVE
      print("(user clicked on selected to deselect)")
      selectedIndexPath = nil
      var indexPathToRemove : NSIndexPath
      
      tableView.deselectRowAtIndexPath(indexPath, animated:false)
      switch (indexPath.section, indexPath.row)
      {
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
      default: return
      }
      NSLog("removing")
      print(indexPathToRemove)
      self.tableView.beginUpdates()
      self.tableView.deleteRowsAtIndexPaths(NSArray(object:indexPathToRemove) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
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
        //self.sectionZero.removeAtIndex(selectedRow + 1)
        break
      case 1 :
        self.sectionOne.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 1)
      case 2:
        self.sectionTwo.removeAtIndex(selectedRow  + 1) //content shown 1 row below
        indexPathToRemove = NSIndexPath(forRow: selectedRow + 1, inSection: 2)
        
      default: break
      }
      
      if(indexPathToRemove != nil)
      {
        self.tableView.beginUpdates()
        self.tableView.deleteRowsAtIndexPaths(NSArray(object: indexPathToRemove!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
        print(sectionTwo)
        self.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        self.tableView.endEditing(true)
      }
    }
    
    // no previous selection
    selectedIndexPath = NSIndexPath(forRow: currentRow, inSection: currentSection)
    
    var indexPathToInsert : NSIndexPath
    
    // update the data source
    switch (currentSection, currentRow) {
      
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
      
    default: return
      
    }
    
    indexPathToInsert = NSIndexPath(forRow: currentRow + 1, inSection: currentSection)
    
    self.tableView.beginUpdates()
    self.tableView.insertRowsAtIndexPaths(NSArray(object: indexPathToInsert) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    self.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
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
          return CGFloat(230)
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
        
      default : break
      }
      
      //This is for the text view
      //It's not included in the cases above because the
      //text view covers the cell and the cell can not be
      //selected
      
      if((indexPath.section == 2 && indexPath.row == 1 ) ||
        (indexPath.section == 2 && indexPath.row == 2)   )
      {
        return CGFloat(150)
      }
    }
      
    else if((indexPath.section == 2 && indexPath.row == 1 ) ||
      (indexPath.section == 2 && indexPath.row == 2)   )
      
    {
      return CGFloat(150)
    }
    
    return CGFloat(48)
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
  
  ///////////////////
  //private methods//
  ///////////////////
  
  //This method takes a string and shows an alert with that message
  
  func showCancelUIAlert(title          : String,
    titleComment   : String,
    message        : String,
    messageComment : String)
  {
    let alert = UIAlertController(
      title  : NSLocalizedString(title, comment: titleComment),
      message: NSLocalizedString(message, comment: messageComment),
      preferredStyle : UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title :"Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
    alert.addAction(cancelAction)
    self.presentViewController(alert, animated: true , completion: nil)
    return
  }
  
  
  
  @IBAction func createGroup(sender: AnyObject) {
    
    ///////////////////////
    //Validate user input//
    ///////////////////////
    
    //This checks if there is any mandatory fields is missing
    if(
      groupName == nil || groupName!.isEmpty  == true ||
        size      == nil || size?.isEmpty       == true ||
        address   == nil || address?.isEmpty    == true ||
        city      == nil || city?.isEmpty       == true ||
        province  == nil || province?.isEmpty   == true ||
        time      == nil || time?.isEmpty       == true ||
        date      == nil || date?.isEmpty       == true ||
        sport     == nil || sport?.isEmpty      == true )
    {
      print(self)
      self.showCancelUIAlert(
        "Error",
        titleComment: "",
        message:"Empty fields",
        messageComment: "")
      return
    }
    
    var groupLocation = (address)! + ","
    groupLocation    += (city)! + "," + (province)!
    
    //This gets the geographic coordinates from an address string
    //using the geocoder class and returns an alert if the address is not found
    geocoder!.geocodeAddressString(
      groupLocation,
      completionHandler: { (placemarks :[CLPlacemark]?,errorOrNil : NSError?) -> Void in
        
        if(errorOrNil != nil || placemarks == nil)
        {
          //Error
          self.showCancelUIAlert(
            "Error",
            titleComment   : "Group Creation Error",
            message        : "Location is not valid",
            messageComment : "Wrong Location")
          return
        }
        else
        {
          //Success
          let firstPlacemark = placemarks?[0]
          let location = (firstPlacemark!.location)!
          self.saveGroup(location)
        }
    })
  }
  
  // Sends group data to the database
  func saveGroup(groupLocation: CLLocation)
  {
    //Kinvey API method that creates a store object
    //so we can save entities to a specific collection
    let storeGroup = KCSAppdataStore.storeWithOptions(
      [KCSStoreKeyCollectionName : "Groups",
        KCSStoreKeyCollectionTemplateClass : Group.self])
    
    
    //This creates a query that checks whether the group already exists by
    //changing the user input to all lowercases and comparing it to other names in the database
    let query = KCSQuery(onField: "nameLowercase", withExactMatchForValue: groupName!.lowercaseString)
    
    //execute the query
    storeGroup.countWithQuery(query) { (count :UInt, errorOrNil :NSError!) -> Void in
      
      //if the group already exists
      if(errorOrNil != nil)
      {
        //there is an error, possibly internet error
        return
        
      }
        
      else if(count > 0)
      {
        self.showCancelUIAlert(
          "Error",
          titleComment: "",
          message:"Group already exists",
          messageComment: "")
        return
      }
        
      else if(Int(self.size!) <= 1)
      {
        //Prevent user from making a group with size of 1 or less
        
        self.showCancelUIAlert(
          "Error",
          titleComment: "",
          message:"Group size must be at least 2",
          messageComment: "")
        return
      }
      
      //The following 4 lines get the current date of the system
      let tempDate  = NSDate()
      let formatter = NSDateFormatter()
      formatter.dateStyle = NSDateFormatterStyle.ShortStyle
      let currentDate = formatter.stringFromDate(tempDate)
      
      
      //Kinvey API method that creates a Group instance and saving to the database
      //and assigns user input to the instance properties
      let group = Group()
      
      //Mandatory properties
      group.name          = self.groupName
      group.nameLowercase = self.groupName!.lowercaseString
      group.owner         = KCSUser.activeUser().userId
      group.dateCreated   = currentDate
      group.startTime     = self.time
      group.startDate     = self.date
      group.sport         = self.sport
      group.category      = self.category
      print(group.category)
      group.maxSize       = Int(self.size!)
      group.currentSize   = 1  //only 1 member when it's first created
      group.address       = self.address
      group.city          = self.city
      group.province      = self.province
      group.geoLocation   = groupLocation
      group.metadata?.setGloballyWritable(false)
      
      
      //Optional properties
      
      
      //Should already have been checked but redundancy
      if(self.note != nil)
      {
        group.detail  = self.note
      }
        
      else
      {
        group.detail = "Come Join In!"
      }
      
      
      
      //This method saves the changes and uploads the newly created entity to the database
      storeGroup.saveObject(
        group,
        withCompletionBlock: {(objectsOrNil:[AnyObject]!, errorOrNil :NSError!) -> Void in
          if (errorOrNil != nil)
          {
            print(errorOrNil.userInfo[KCSErrorCode])
            print(errorOrNil.userInfo[KCSErrorInternalError])
            print(errorOrNil.userInfo[NSLocalizedDescriptionKey])
            
            //identify the error domain
            let message = errorOrNil.userInfo[NSLocalizedDescriptionKey] as! String?
            
            //create an alert to tell user there is an error
            self.showCancelUIAlert(
              "Error",
              titleComment: "",
              message:message!,
              messageComment: "")
            return
            
          }
          else
          {
            //Save was sucessful
            //TODO:bring user to their group page
            NSLog("Successfullly saved event(id ='%@').",(objectsOrNil[0] as! NSObject).kinveyObjectId())
            
            let alert = UIAlertController(
              title  : NSLocalizedString("Success", comment: "group is successfully created "),
              message: "Your group has been created ",
              preferredStyle: UIAlertControllerStyle.Alert
            )
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
              
              //Todo:Bring user to their group
              self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
          }
        },
        withProgressBlock : nil)
      
    }
  }
  
  
  @IBAction func BackToLFG(sender: UIBarButtonItem) {
    
    //unwind back to MainCVController
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
