//
//  PasswordChangedView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//

import SwiftUI

struct PasswordChangedView: View {
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Placeholder for the mascot/character
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
            
            Text("Password changed")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your password has been changed successfully!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Back to login button
            NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                Button(action: {
                    navigateToLogin = true
                }) {
                    Text("Back to login")
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
    PasswordChangedView()
}
