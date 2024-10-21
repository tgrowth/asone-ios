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
            VStack(spacing: 10) {
                Spacer()

                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Adjust size as needed

                Spacer()

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

                VStack(spacing: 10){
                    NavigationLink(destination: LoginView()) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: SignUpView()) {
                        Text("Create account")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.padding()

                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    WelcomeView()
}
