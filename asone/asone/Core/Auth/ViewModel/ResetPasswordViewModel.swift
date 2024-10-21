//
//  ResetPasswordViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/20/24.
//

import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject {
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordValid: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isPasswordReset: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validatePasswords()
    }
    
    private func validatePasswords() {
        Publishers.CombineLatest($newPassword, $confirmPassword)
            .map { newPassword, confirmPassword in
                return !newPassword.isEmpty && newPassword == confirmPassword && newPassword.count >= 6
            }
            .assign(to: &$isPasswordValid)
    }
    
    func sendResetPasswordRequest() async throws {
        guard !newPassword.isEmpty || !confirmPassword.isEmpty else {
            errorMessage = "Password fields cannot be empty"
            return
        }

        errorMessage = ""

        Task {
            do {
                try await ApiService.shared.resetPassword(
                    newPassword: newPassword,
                    token: AuthService().userSession?.getIDToken() ?? "unknown token")
                DispatchQueue.main.async {
                    self.isPasswordReset = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to reset password. Please try again."
                    self.isPasswordReset = false
                }
            }
        }
    }
    
    func resetState() {
        newPassword = ""
        confirmPassword = ""
        isPasswordReset = false
        errorMessage = nil
    }
}
