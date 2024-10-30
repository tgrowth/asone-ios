//
//  SignUpView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import AuthenticationServices

struct SignUpView: View {

    @StateObject var viewModel = SignUpViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss;
    @State private var isRegistered: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Header(title: "Create account")
                
                Spacer()
                
                // Name Field
                CustomTextField(placeholder: "Full Name", text: $viewModel.fullname)
                
                // Email Field
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                
                // Password Field
                CustomTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                
                // Sign Up Button
                PrimaryButton(title: "Sign Up", action: {
                    Task {
                        do {
                            try await viewModel.register()
                            // Set isRegistered to true after successful registration
                            isRegistered = true
                        } catch {
                            // Handle any registration errors here
                            print("Registration failed: \(error.localizedDescription)")
                        }
                    }
                }, isDisabled: viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.fullname.isEmpty)

                
                Spacer()

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                    Text("Or")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)

                // Social login buttons
                HStack(spacing: 20) {
                    // Google
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                        Task { try await loginViewModel.googleLogin() }
                    }
                    .frame(height: 40)

                    // Apple Login
                    SignInWithAppleButton(.signIn) { request in
                        let nonce = loginViewModel.randomNonceString()
                        request.nonce = loginViewModel.sha256(nonce)
                        loginViewModel.nonce = nonce
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            Task { try await loginViewModel.appleLogin(authorization) }
                        case .failure(let error): print("ERROR: \(error)")
                        }
                    }
                    .frame(height: 40)
                }
                .padding(.horizontal)
                
                Button{
                    dismiss()
                } label: {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .foregroundColor(.black)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    SignUpView()
}
