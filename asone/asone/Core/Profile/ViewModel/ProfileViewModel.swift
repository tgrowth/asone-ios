//
//  ProfileViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/2/24.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var uid: String = ""
    @Published var email: String = ""
    @Published var displayName: String = ""
    
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        //setUpSubscribers()
        fetchCurrentUser()
    }
    
//    private func setUpSubscribers(){
//        UserService.shared.$currentUser.sink { [weak self] user in
//            self?.currentUser = user
//        }.store(in: &cancellables)
//    }

    func fetchCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.uid = user.uid
            self.email = user.email ?? "No Email"
            self.displayName = user.displayName ?? "No Name"
        } else {
            print("No user is logged in")
        }
    }
}
