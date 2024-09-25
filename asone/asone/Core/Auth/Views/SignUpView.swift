//
//  SignUpView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI

struct SignUpView: View {

    @StateObject var viewModel = SignUpViewModel()
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("AsOne")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Name Field
                CustomTextField(placeholder: "First and Last Name", text: $viewModel.fullname)
                
                // Email Field
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                
                // Password Field
                CustomTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                
                // Sign Up Button
                PrimaryButton(title: "Sign Up", action: {
                    Task { try await viewModel.register() }
                }, isDisabled: viewModel.email.isEmpty ||  viewModel.password.isEmpty ||  viewModel.fullname.isEmpty)
                
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
                        // Apple Sign Up action
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
                        // Google Sign Up action
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
