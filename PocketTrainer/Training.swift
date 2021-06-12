//
//  Training.swift
//  PocketTrainer
//
//  Created by Misha on 17.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import Foundation

struct Training : Codable {
    
    var group: String
    var exerciseName: String
    var image: String
    var majorMuscles: String
    var extraMuscles: String
    var complexityOfImplementation: String
    var equipment: String
    var description: String
    var calories: Double
}
