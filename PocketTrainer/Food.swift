//
//  Food.swift
//  PocketTrainer
//
//  Created by Misha on 14.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import Foundation

struct Food : Codable {
    var name: String
    var weight: Int
    var fat: Double
    var protein: Double
    var calories: Double
    var carbohydrates: Double
    var date: String
}
