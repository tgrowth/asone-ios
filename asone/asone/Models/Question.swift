//
//  Question.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/15/24.
//

import Foundation

struct Question: Codable, Identifiable {
    let id: Int
    let text: String
    let optionA: String
    let optionB: String
    var selectedOption: Int?
}
