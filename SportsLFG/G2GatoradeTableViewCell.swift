//
//  G2GatoradeTableViewCell.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-30.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation
import UIKit 
import HealthKit


protocol SavingHKSamplesDelegate
{
  func didFinishLoadingHKSamplesDelegate()
}




class G2Gatorade{
  
  //Ingredients
  
  var Calories : UInt = 20
  var Sodium   : UInt = 115
  var Potassium: UInt = 30
  var Sugars   : UInt = 5
  
}

class G2GatoradeTableViewCell : UITableViewCell,UITextFieldDelegate
{
  
  var healthManager : HealthManager?
  var delegateObject : SavingHKSamplesDelegate?
  
  @IBOutlet weak var bottlesConsumed: UILabel!
  @IBOutlet weak var countStepper: UIStepper!
  
  //Nutrition 
  @IBOutlet weak var Calories: UITextField!
  @IBOutlet weak var Sodium: UITextField!
  @IBOutlet weak var Potassium: UITextField!
  @IBOutlet weak var Sugars: UITextField!
  
  @IBOutlet weak var todayData: UILabel!
  @IBOutlet weak var weekData: UILabel!
  
  
  
  @IBAction func stepperPressed(sender: UIStepper) {
    
    self.bottlesConsumed.text = String(sender.value)
    
    let G2GatoradeObject = G2Gatorade()
    
    self.Calories.text  = String((G2GatoradeObject.Calories)  * UInt(sender.value))
    
    self.Sodium.text    = String((G2GatoradeObject.Sodium)    * UInt(sender.value))
    
    self.Potassium.text = String((G2GatoradeObject.Potassium) * UInt(sender.value))
    
    self.Sugars.text    = String((G2GatoradeObject.Sugars)    * UInt(sender.value))
    
    
  }
  
  
  
  @IBAction func saveHKSample(sender: UIButton) {
    
    let currentDate = NSDate()
    
    self.healthManager?.saveCalorySample(Double(self.Calories.text!)!, date:currentDate)
    self.healthManager?.saveSodiumSample(Double(self.Sodium.text!)!, date:currentDate)
    self.healthManager?.savePotassiumSample(Double(self.Potassium.text!)!, date:currentDate)
    self.healthManager?.saveSugarSample(Double(self.Potassium.text!)!, date:currentDate)
    
    self.delegateObject?.didFinishLoadingHKSamplesDelegate()
    
  }
}