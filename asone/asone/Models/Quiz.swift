//
//  Quiz.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import Foundation

struct Quiz: Codable, Identifiable {
    let id: Int
    let title: String
    var isComplete: Bool
    var questions: [Question]
    let scoringGuide: ScoringGuide
}
