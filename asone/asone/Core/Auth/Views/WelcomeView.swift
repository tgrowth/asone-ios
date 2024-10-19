//
//  AuthView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // Mascot Image
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Adjust size as needed

                Spacer()

                // Title and Subtitle
                VStack(spacing: 10) {
                    Text("Welcome to AsOne")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Take control of your well-being and let your partner be a part of the journey")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)

                // Sign In Button with Navigation
                NavigationLink(destination: LoginView()) {
                    Text("Sign In")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)

                // Create Account Button with Navigation
                NavigationLink(destination: SignUpView()) {
                    Text("Create account")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)

                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    WelcomeView()
}
