//
//  VerificationCodeView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//

import SwiftUI

struct VerificationCodeView: View {
    @State private var code = ""
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
            
            // Verification Code Fields
            TextField(" ", text: $code)
                .padding()
                .keyboardType(.numberPad)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            
            // Verify button
            NavigationLink(destination: ResetPasswordView(), isActive: $navigateToResetPassword) {
                Button(action: {
                    // Verification logic here
                    navigateToResetPassword = true
                }) {
                    Text("Verify")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .padding(.top)
            
            // Resend code
            Button(action: {
                // Resend code logic
                resendTimer = 60
            }) {
                Text("Send code again \(resendTimer)")
                    .foregroundColor(.gray)
            }
            .padding(.top)
            
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
    VerificationCodeView()
}
