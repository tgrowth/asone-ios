//
//  SettingsViewModel 2.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/21/24.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var cycleLength: Int = 28
    @Published var periodLength: Int = 5
    @Published var pregnancyProbability: Bool = true
    @Published var weekStart: String = "Sun."
    
    @Published var notifications: [String: Bool] = [
        "Period starting soon": true,
        "Period ending": false,
        "Period starts": false,
        "Ovulation": true,
        "Contraceptives": false
    ]
}

