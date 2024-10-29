//
//  SettingsViewModel 2.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/21/24.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var pregnancyProbability: Bool = true
    @Published var weekStart: String = "Sun."
    @Published var cycleLength: Int = 28 {
        didSet {
            Task {
                await updateUserData(uid: AuthService.shared.userSession?.uid ?? "unknown uid")
            }
        }
    }
    
    @Published var periodLength: Int = 5 {
        didSet {
            Task {
                await updateUserData(uid: AuthService.shared.userSession?.uid ?? "unknown uid")
            }
        }
    }
    
    @Published var notifications: [String: Bool] = [
        "Period starting soon": true,
        "Period ending": false,
        "Period starts": false,
        "Ovulation": true,
        "Contraceptives": false
    ]
    
    func fetchUserData(uid: String) async {
        UserService.shared.fetchUserData(uid: uid) { [weak self] userData in
            guard let self = self, let userData = userData else {
                print("No user data found or an error occurred.")
                return
            }
            
            DispatchQueue.main.async {
                self.cycleLength = userData.cycleLength
                self.periodLength = userData.periodLength
            }
        }
    }
    
    func updateUserData(uid: String) async {
        let userData: [String: Any] = [
            "cycleLength": cycleLength,
            "periodLength": periodLength,
        ]
        
        do {
            try await UserService.shared.updateUserData(uid: uid, userData: userData)
        } catch {
            print("Failed to update user data: \(error.localizedDescription)")
        }
    }
}
