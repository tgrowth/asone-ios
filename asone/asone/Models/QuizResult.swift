//
//  QuizResult.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/10/24.
//

struct QuizResult: Codable {
    let quizName: String
    let userId: String?
    let answers: [Answer]
}
