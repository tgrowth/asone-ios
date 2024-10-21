//
//  VerificationCodeViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/20/24.
//

import SwiftUI
import Combine

class VerificationCodeViewModel: ObservableObject {
    @Published var verificationCode: String = ""
    @Published var isCodeValid: Bool = false
    @Published var isVerified: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateCodeInput()
    }
    
    func validateCodeInput() {
        $verificationCode
            .map { code in
                return code.count == 6 && code.allSatisfy { $0.isNumber }
            }
            .assign(to: &$isCodeValid)
    }
    
    func sendVerificationRequest() async throws {
        guard !verificationCode.isEmpty else {
            errorMessage = "Verification Code field cannot be empty"
            return
        }

        errorMessage = ""

        Task {
            do {
                try await ApiService.shared.verifyCode(verificationCode: verificationCode)
                DispatchQueue.main.async {
                    self.isVerified = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Verification failed. Please try again."
                    self.isVerified = false
                }
            }
        }
    }
    
    func resetState() {
        verificationCode = ""
        isVerified = false
        errorMessage = nil
    }
}
