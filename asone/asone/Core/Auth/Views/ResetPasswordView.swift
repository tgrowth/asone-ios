//
//  ResetPasswordView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//


import SwiftUI

struct ResetPasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var navigateToPasswordChanged = false
    
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
            
            // New password field
            SecureField("New password", text: $newPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.default)
            
            // Confirm password field
            SecureField("Confirm password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.default)
            
            // Reset password button
            NavigationLink(destination: PasswordChangedView(), isActive: $navigateToPasswordChanged) {
                Button(action: {
                    // Reset password logic here
                    navigateToPasswordChanged = true
                }) {
                    Text("Reset password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}


#Preview{
    ResetPasswordView()
}
