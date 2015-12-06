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
    
    weak var delegateObject : TitleTableViewCell?
    
    var currentState : String?
    
    override func awakeFromNib() {
        //Whenever the value is changed in date picker,
        //the text on the currentSelected will get updated
        datePicker.addTarget(self, action: Selector("updateDate"), forControlEvents: UIControlEvents.ValueChanged)
    }

    func updateDate()
    {
        let selectedDate = dateFormatter!.stringFromDate(datePicker.date)
        delegateObject?.rightLabel.text = selectedDate
    }
    
}