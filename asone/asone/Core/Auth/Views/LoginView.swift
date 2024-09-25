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
                HStack {
                    Button(action: {
                        // Apple Sign In action
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(8)
                    }
                    
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
