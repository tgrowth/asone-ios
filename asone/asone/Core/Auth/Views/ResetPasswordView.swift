//
//  ResetPasswordView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//


import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Reset password")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Please type something you’ll remember.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            SecureField("New password", text: $viewModel.newPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.default)
            
            SecureField("Confirm password", text: $viewModel.confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.default)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            NavigationLink(destination: PasswordChangedView(), isActive: $viewModel.isPasswordReset) {
                PrimaryButton(title: "Reset password", action: {
                    Task { try await viewModel.sendResetPasswordRequest() }
                }, isDisabled: !viewModel.isPasswordValid || viewModel.newPassword.isEmpty || viewModel.confirmPassword.isEmpty)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}


#Preview{
    ResetPasswordView()
}
