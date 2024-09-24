//
//  LoginView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // App Title or Logo (if you want to replace this with an image, use Image())
                Text("AsOne")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Email Field
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                
                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                // Remember Me Toggle and Forgot Password Button
                Toggle("Remember me", isOn: $rememberMe)
                    .padding()
                
                Button("Forgot your password?") {
                    // Forgot password action
                }
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                
                // Login Button
                Button(action: {
                    // Perform login action here
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                
                // Sign up button
                Button(action: {
                    // Handle sign-up
                }) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
                
                Spacer()
                
                // Divider with "or"
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
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // Google Sign In action
                    }) {
                        HStack {
                            Text("Google")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
