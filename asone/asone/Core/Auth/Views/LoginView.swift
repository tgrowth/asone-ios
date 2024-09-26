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
                Spacer()
                
                Text("AsOne")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Email Field
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                
                // Password Field
                CustomTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                
                NavigationLink("Forgot your password?") {
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
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                    Text("or")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                // Sign in with Apple and Google
                VStack {
                    SignInWithAppleButton(.signIn){ request in
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
                
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                            Task { try await viewModel.googleLogin()
                        }
                    }
                }
                .padding(.horizontal)
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign Up")
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
    LoginView()
}
