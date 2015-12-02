//
//  EnergyDrink.swift
//  SportsLFG
//
//  Created by CharlesL on 2015-11-28.
//  Copyright © 2015 CMPT-GP03. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager
{
  let healthKitStore : HKHealthStore = HKHealthStore() 
  
  func authorizeHealthKit(completion :((success: Bool, error:NSError!)-> Void)!)
  {
    let healthKitTypesToRead : Set = [HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryWater)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCaffeine)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryPotassium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySodium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
    ]
    
    let healthKitTypesToWrite : Set = [HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryWater)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCaffeine)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryPotassium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySodium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
    ]
    
    
    
    if !HKHealthStore.isHealthDataAvailable()
    {
      let error = NSError(domain:"CMPT275-2015-GP03", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
      if(completion != nil)
      {
        completion(success:false, error:error)
      }
      return
    }
    
    healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite , 
      readTypes: healthKitTypesToRead) 
      {(success, error) -> Void in
        if (completion != nil)
        {
          completion(success:success, error:error)
        }
    }
  }
  
  
  func saveCalorySample(calory : Double, date :NSDate)
  {
    
    let caloryType     = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
    let caloryQuantity = HKQuantity(unit: HKUnit.calorieUnit(), doubleValue: calory)
    let calorySample   = HKQuantitySample(type: caloryType, quantity: caloryQuantity, startDate: date, endDate: date)
    
    healthKitStore.saveObject(calorySample, withCompletion: { (success, error) -> Void in
      if( error != nil ) {
        print("Error saving Calories sample: \(error!.localizedDescription)")
      } else {
        print("Calories sample saved successfully!")
      }
    })
  }

  func saveSodiumSample(sodium : Double, date :NSDate)
  {
    
    let sodiumType     = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySodium)!
    let sodiumQuantity = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: sodium)
    let sodiumSample   = HKQuantitySample(type: sodiumType, quantity: sodiumQuantity, startDate: date, endDate: date)
    
    healthKitStore.saveObject(sodiumSample, withCompletion: { (success, error) -> Void in
      if( error != nil ) {
        print("Error saving Sodium sample: \(error!.localizedDescription)")
      } else {
        print("Sodium sample saved successfully!")
      }
    })
  }

  func savePotassiumSample(potassium : Double, date :NSDate)
  {
    
    let potassiumType    = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryPotassium)!
    let potassiumQuantity = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: potassium)
    let potassiumSample   = HKQuantitySample(type: potassiumType, quantity: potassiumQuantity, startDate: date, endDate: date)
    
    healthKitStore.saveObject(potassiumSample, withCompletion: { (success, error) -> Void in
      if( error != nil ) {
        print("Error saving Potassium sample: \(error!.localizedDescription)")
      } else {
        print("Potassium sample saved successfully!")
      }
    })
  }

  func saveSugarSample(sugar : Double, date :NSDate)
  {
    let sugarType     = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar)!
    let sugarQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: sugar)
    let sugarSample   = HKQuantitySample(type: sugarType, quantity: sugarQuantity, startDate: date, endDate: date)
    
    healthKitStore.saveObject(sugarSample, withCompletion: { (success, error) -> Void in
      if( error != nil ) {
        print("Error saving Sugar sample: \(error!.localizedDescription)")
      } else {
        print("Sugar sample saved successfully!")
      }
    })
  }

  
  
  
  
  
}
