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
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar)!
    ]
    
    let healthKitTypesToWrite : Set = [HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryWater)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCaffeine)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryPotassium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySodium)!,
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar)!
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
  
  
  
  
  
  
  
  
}
