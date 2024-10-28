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
    @Published var name: String = ""
    @Published var currentUser: UserData?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.uid = user.uid
            self.email = user.email ?? "No Email"
            self.name = user.displayName ?? "No Name"
            self.fetchUserProfile(uid: user.uid)
        } else {
            print("No user is logged in")
        }
    }

    func fetchUserProfile(uid: String) {
        UserService.shared.fetchUserData(uid: uid) { [weak self] userProfile in
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
    
    func deleteAccount() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }

        do {
            try await ApiService.shared.deleteAccount(uid: uid)
            print("Backend account deletion successful.")
            
            try await AuthService.shared.deleteFirebaseUser()
            print("Firebase user deletion successful.")
        } catch {
            print("Failed to delete account: \(error.localizedDescription)")
        }
    }
}
