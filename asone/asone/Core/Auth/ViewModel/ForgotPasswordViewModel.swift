//
//  ForgotPasswordViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = "";
    
    @MainActor
    func resetPassword() async throws {
        try await AuthService.shared.resetPassword(withEmail: email)
    }
}
