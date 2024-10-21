//
//  ForgotPasswordView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var viewModel = ForgotPasswordViewModel()
    @State private var navigateToVerification = false
    @State private var isEmailSent: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Don’t worry! It happens. Please enter the email associated with your account.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
                
                CustomTextField(placeholder: "Email", text: $viewModel.email)

                NavigationLink(destination: VerificationCodeView(email: viewModel.email), isActive: $navigateToVerification) {
                    PrimaryButton(
                        title: "Send code",
                        action: {
                            Task { try await viewModel.sendForgotPasswordRequest() }
                            
                            navigateToVerification = true
                            isEmailSent = true
                        },
                        isDisabled: viewModel.email.isEmpty
                    )
                }
                .padding()

                if isEmailSent {
                    Text("A reset link has been sent to your email.")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
        .navigationTitle("Forgot Password")
    }
}

#Preview {
    ForgotPasswordView()
}
