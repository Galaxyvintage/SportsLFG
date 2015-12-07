//
//  DatePickerTableViewCell.swift
//  SportsLFG
//
//  Created by Zheyang Li on 2015-12-05.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//


import UIKit

class DatePickerTableViewCell : UITableViewCell
{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateFormatter : NSDateFormatter? 
    var timeFormatter : NSDateFormatter?
    
    weak var parentCell : TitleTableViewCell?
    weak var parentController : GroupTableViewController_2?
    
    var currentState : String?
    
    //It would be better to let the table view controller to handle,
    //but for now let's just keep it this way since there is no time left
    override func awakeFromNib() {
        
        //Whenever the value is changed in date picker,
        //the text on the currentSelected will get updated
        
        datePicker.addTarget(self, action: Selector("updateDate"), forControlEvents: UIControlEvents.ValueChanged)
    }

    func updateDate()
    {
        let time = timeFormatter!.stringFromDate(datePicker.date)
        let date = dateFormatter!.stringFromDate(datePicker.date)
        
        parentController?.date = date
        parentController?.time = time
        
        let selectedDate = date  + "," + time
        parentController?.dictOne[2] = selectedDate
        parentCell?.rightLabel.text = selectedDate
        parentCell?.rightLabel.textColor = UIColor.blackColor()
    }
    
}