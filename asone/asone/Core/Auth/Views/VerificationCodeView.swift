//
//  VerificationCodeView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//

import SwiftUI

struct VerificationCodeView: View {
    let email: String
    
    @StateObject var viewModel = VerificationCodeViewModel()
    @State private var navigateToResetPassword = false
    @State private var resendTimer = 60
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Please check your email")
                .font(.title)
                .fontWeight(.bold)
            
            Text("We’ve sent a code to the email address you provided.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            CustomTextField(placeholder: "Code", text: $viewModel.verificationCode)
            
            NavigationLink(destination: ResetPasswordView(), isActive: $navigateToResetPassword) {
                PrimaryButton(
                    title: "Verify",
                    action: {
                        Task { try await viewModel.sendVerificationRequest() }
                        
                        navigateToResetPassword = true
                    },
                    isDisabled: viewModel.verificationCode.isEmpty
                )
            }
            .padding()
            
            // Resend code
            PrimaryButton(title: "Send code again \(resendTimer) sec", action: {
                Task { try await ApiService.shared.forgotPassword(email: email) }
                
                resendTimer = 60
                startResendTimer()
            }, isDisabled: resendTimer != 0)
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            // Start the timer
            startResendTimer()
        }
    }
    
    // Timer function
    func startResendTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if resendTimer > 0 {
                resendTimer -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    VerificationCodeView(email: "example@gmail.com")
}
