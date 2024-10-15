//
//  UserProfile.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/15/24.
//

struct UserProfile: Codable {
    let id: Int
    let isUsingForSelf: Bool
    let code: String
    let birthday: String
    let periodLength: Int
    let cycleLength: Int
    let lastPeriodDate: String
    let isTryingToConceive: Bool
    let isPartnerMode: Bool
    let partnerEmail: String
    let inviteCode: String
    let isComplete: Bool
}
