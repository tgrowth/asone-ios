//
//  UserData.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import Foundation

struct UserData: Decodable {
    var id: Int? = nil
    var uid: String = ""
    var username: String = ""
    var avatar: Data? = nil
    var isUsingForSelf: Bool = true
    var birthday: Date = Date()
    var state: String = ""
    var periodLength: Int = 7
    var cycleLength: Int = 7
    var lastPeriodStartDate: Date = Date()
    var lastPeriodEndDate: Date = Date()
    var isTryingToConceive: Bool = false
    var mood: Double = 1.0
    var symptoms: [Int] = []
    var partnerMode: Bool = false
    var partnerUid: String? = nil
    var code: String = ""
    var isComplete: Bool = false
}
