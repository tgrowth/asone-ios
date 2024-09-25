//
//  ForgotPasswordView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    @State private var isEmailSent: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // App Title or Logo
                Text("AsOne")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Reusable Custom Text Field for Email
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                
                // Reset Password Button
                PrimaryButton(title: "Send Reset Link", action: {
                    // Reset Password
                }, isDisabled: viewModel.email.isEmpty)
                
                // If email has been sent, show a confirmation message
                if isEmailSent {
                    Text("A reset link has been sent to your email.")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
