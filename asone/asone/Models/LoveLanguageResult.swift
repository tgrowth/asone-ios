//
//  LoveLanguageResult.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/11/24.
//


struct LoveLanguageResult: Codable {
    let user_id: Int
    let language_ids: [Int]  // [1, 2, 3, 4, 5]
    let percentages: [Int]   // [e.g. 30, 25, 20, 15, 10]
}

