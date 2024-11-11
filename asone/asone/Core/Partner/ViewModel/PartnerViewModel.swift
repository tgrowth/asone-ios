//
//  PartnerViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/16/24.
//

import Foundation
import Combine

class PartnerViewModel: ObservableObject {
    @Published var partner: UserData?
    @Published var currentDay = "Wed"
    @Published var tips = [
        "Thank your partner for being understanding during your luteal phase. Even a simple 'I appreciate you' can make a difference.",
        "Feeling a bit emotional? Share your thoughts with your partner—they'll appreciate the trust you put in them."
    ]
    @Published var feedbackRating = 3

    
    func fetchPartnerProfile(uid: String) {
        UserService.shared.fetchPartnerData(uid: uid) { [weak self] userProfile in
            guard let self = self else { return }

            if let userProfile = userProfile {
                DispatchQueue.main.async {
                    self.partner = userProfile
                }
            } else {
                print("Failed to fetch user profile")
            }
        }
    }
}

struct Emotion: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var iconName: String
}
