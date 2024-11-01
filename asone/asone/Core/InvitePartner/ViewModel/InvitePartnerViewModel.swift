//
//  InvitePartnerViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import SwiftUI
import FirebaseAuth

class InvitePartnerViewModel: ObservableObject {
    @Published var inviteCode: String?
    @Published var errorMessage: String?

    init() {
        checkAndFetchInviteCode()
    }

    // Fetch the invite code if the user's data is complete
    func checkAndFetchInviteCode() {
        guard let user = Auth.auth().currentUser else {
            self.inviteCode = nil
            return
        }

        UserService.shared.fetchUserData(uid: user.uid) { [weak self] userData in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let userData = userData {
                    if userData.isComplete {
                        self.inviteCode = userData.code
                    } else {
                        self.inviteCode = OnboardingViewModel.shared.inviteCode
                    }
                } else {
                    self.errorMessage = "Failed to fetch user data."
                }
            }
        }
    }
    
    // Pair the partner by sending the uid and code
    func pairPartner(uid: String, code: String) {
        UserService.shared.addPartner(uid: uid, code: code) { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if success {
                    self.inviteCode = code
                    self.errorMessage = nil
                } else {
                    self.errorMessage = "Failed to pair with the partner."
                }
            }
        }
    }
}
