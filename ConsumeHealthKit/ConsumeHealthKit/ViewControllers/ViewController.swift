//
//  ViewController.swift
//  ConsumeHealthKit
//
//  Created by dos Santos, Diego on 22/02/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var healthKitService: HealthKitService?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        healthKitService = HealthKitService()
        healthKitService?.readHeartRateData()
    }
}
