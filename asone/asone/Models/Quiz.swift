//
//  Quiz.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

struct Quiz: Codable {
    let name: String
    var isComplete: Bool
    var questions: [Question]
}
