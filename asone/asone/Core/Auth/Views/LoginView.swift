//
//  LoginView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//


import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import AuthenticationServices

struct LoginView: View {

    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Top spacer for centering elements
                Spacer()
                
                // Welcome text with emoji and icon
                HStack {
                    Text("Hi, Welcome to AsOne")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()

                // Email Field
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                
                // Password Field
                CustomTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)

                // Forgot Password
                NavigationLink("Forgot password?") {
                    ForgotPasswordView()
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

                // Login Button
                PrimaryButton(title: "Login", action: {
                    Task { try await viewModel.login() }
                }, isDisabled: viewModel.email.isEmpty || viewModel.password.isEmpty)

                // Spacer between login button and social login options
                Spacer()

                // Divider with "or"
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
                        Task { try await viewModel.googleLogin() }
                    }
                    .frame(height: 40)

                    // Apple Login
                    SignInWithAppleButton(.signIn) { request in
                        let nonce = viewModel.randomNonceString()
                        request.nonce = viewModel.sha256(nonce)
                        viewModel.nonce = nonce
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            Task { try await viewModel.appleLogin(authorization) }
                        case .failure(let error): print("ERROR: \(error)")
                        }
                    }
                    .frame(height: 40)
                }
                .padding(.horizontal)

                // Sign up link
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .padding()
                }

                Spacer()
            }
            .padding(.top) // Adjust padding to ensure proper layout
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}
