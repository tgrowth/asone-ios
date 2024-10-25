//
//  Symptom.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/24/24.
//

import Foundation

struct Symptom: Identifiable, Codable, Hashable {
    let id: Int
    let type: String
    let name: String
}
