//
//  ForgotPasswordViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var successMessage: String = ""

    @MainActor
    func sendForgotPasswordRequest() async throws {
        guard !email.isEmpty else {
            errorMessage = "Email field cannot be empty"
            return
        }

        isLoading = true
        errorMessage = ""
        successMessage = ""

        Task {
            do {
                try await ApiService.shared.forgotPassword(email: email)
                DispatchQueue.main.async {
                    self.successMessage = "Password reset link sent to your email"
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to send reset password link: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
