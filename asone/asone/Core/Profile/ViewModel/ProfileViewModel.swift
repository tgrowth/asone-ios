//
//  ProfileViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//


import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var uid: String = ""
    @Published var email: String = ""
    @Published var displayName: String = ""
    @Published var currentUser: UserProfile?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.uid = user.uid
            self.email = user.email ?? "No Email"
            self.displayName = user.displayName ?? "No Name"
                        
            UserService.shared.getCurrentUserId { [weak self] userId in
                guard let self = self else { return }

                if let userId = userId {
                    self.fetchUserProfile(userId: userId)
                } else {
                    print("No user is logged in or User ID is nil")
                }
            }
        } else {
            print("No user is logged in")
        }
    }

    private func fetchUserProfile(userId: Int) {
        UserService.shared.fetchUserData(userId: userId) { [weak self] userProfile in
            guard let self = self else { return }

            if let userProfile = userProfile {
                DispatchQueue.main.async {
                    self.currentUser = userProfile
                }
            } else {
                print("Failed to fetch user profile")
            }
        }
    }
}
