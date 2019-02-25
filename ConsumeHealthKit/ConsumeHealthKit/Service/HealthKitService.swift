//
//  HealthKitService.swift
//  ConsumeHealthKit
//
//  Created by dos Santos, Diego on 22/02/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitService {
    let healthKitDataStore: HKHealthStore?
    let readableHKCharacteristicTypes: Set<HKQuantityType>?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthKitDataStore = HKHealthStore()
            readableHKCharacteristicTypes = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]

            healthKitDataStore?.requestAuthorization(toShare: nil,
                                                     read: readableHKCharacteristicTypes,
                                                     completion: authRequestCompletion)

        } else {
            healthKitDataStore = nil
            readableHKCharacteristicTypes = nil
        }
    }

    func authRequestCompletion(success: Bool, error: Error?) {
        if success {
            print("Successful authorization.")
        } else {
            print(error.debugDescription)
        }
    }

    func readHeartRateData() {
        // In the Apple documentation you can find every type available: https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!

        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in

            if let samples = samplesOrNil {
                for heartRateSamples in samples {
                    print(heartRateSamples)
                }
            } else {
                print("No heart rate sample available.")
            }
        }

        healthKitDataStore?.execute(query)
    }
}
