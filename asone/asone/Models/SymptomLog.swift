//
//  SymptomLog.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 11/7/24.
//

import Foundation

struct SymptomLog: Codable {
    let uid: String
    let date: String
    let symptoms: [Int]
}

