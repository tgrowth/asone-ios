//
//  InvitePartnerViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import Foundation
import FirebaseAuth

class InvitePartnerViewModel: ObservableObject {
    @Published var inviteCode: String?
    @Published var errorMessage: String?
    var userData: UserData
   
    init(userData: UserData) {
       self.userData = userData
       fetchOrGenerateInviteCode()
   }

    func fetchOrGenerateInviteCode() {
        if let user = Auth.auth().currentUser {
            UserService.shared.fetchUserData(uid: user.uid) { userData in
                DispatchQueue.main.async {
                    if let userData = userData {
                        self.inviteCode = userData.code
                        self.userData.code = userData.code
                    } else {
                        self.generateInviteCode()
                    }
                }
            }
        }
    }

    func generateInviteCode(length: Int = 6) {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let code = String((0..<length).map { _ in characters.randomElement()! })
        self.inviteCode = code
        self.userData.code = code
    }
}
