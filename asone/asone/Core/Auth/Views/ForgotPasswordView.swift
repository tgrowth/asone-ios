//
//  ForgotPasswordView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var viewModel = ForgotPasswordViewModel()
    @State private var navigateToVerification = false
    @State private var isEmailSent: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Forgot password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Don’t worry! It happens. Please enter the email associated with your account.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.trailing) // Padding to match the spacing seen in the design
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                // Email Field
                CustomTextField(placeholder: "Your email", text: $viewModel.email)

                // Send Code Button
                NavigationLink(destination: VerificationCodeView(), isActive: $navigateToVerification) {
                    Button(action: {
                        // Send reset code logic here
                        navigateToVerification = true
                        isEmailSent = true
                    }) {
                        Text("Send code")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                }.padding()

                // Confirmation Text (if email sent)
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
