//
//  Question.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//


struct Question: Codable {
    let text: String
    let choices: [String]
    var selectedChoice: Int? = nil
}
