//
//  TermsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/18/24.
//

import SwiftUI

struct TermsView: View {
    @State private var acceptTerms = false
    @State private var acceptPrivacy = false
    @State private var navigateToAuthView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // Animated Character/Image Placeholder
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                // Title Text
                Text("Welcome to AsOne")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Spacer()
                
                // Terms and Conditions Checkbox
                HStack {
                    Circle()
                        .stroke(acceptTerms ? Color.black : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                        .background(Circle().fill(acceptTerms ? Color.black : Color.clear))
                        .onTapGesture {
                            acceptTerms.toggle()
                        }
                    
                    Text("I agree with Terms and Conditions")
                        .foregroundColor(acceptTerms ? Color.black : Color.gray)
                }
                
                // Privacy Policy Checkbox
                HStack {
                    Circle()
                        .stroke(acceptPrivacy ? Color.black : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                        .background(Circle().fill(acceptPrivacy ? Color.black : Color.clear))
                        .onTapGesture {
                            acceptPrivacy.toggle()
                        }
                    
                    Text("I agree with Privacy Policy")
                        .foregroundColor(acceptPrivacy ? Color.black : Color.gray)
                }
                
                Spacer()
                
                // "Accept All" Button
                Button(action: {
                    acceptTerms = true
                    acceptPrivacy = true
                }) {
                    Text("Accept all")
                        .foregroundColor(.black)
                        .padding()
                }
                
                // "Next Step" Button (NavigationLink to AuthView)
                NavigationLink(destination: WelcomeView(), isActive: $navigateToAuthView) {
                    Button(action: {
                        if acceptTerms && acceptPrivacy {
                            navigateToAuthView = true
                        } else {
                            // Show alert or warning if conditions are not met
                        }
                    }) {
                        Text("Next step")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 30)
            }
            .padding(.horizontal)
        }
    }
}

// Placeholder for AuthView
struct AuthView: View {
    var body: some View {
        Text("Authentication View")
            .font(.largeTitle)
    }
}

#Preview {
    TermsView()
}
