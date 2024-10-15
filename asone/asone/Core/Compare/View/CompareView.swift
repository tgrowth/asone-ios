//
//  CompareView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/14/24.
//


import SwiftUI

struct CompareView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            
            // Placeholder for the mascot or icon
            Spacer()
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
            
            // Text Section
            VStack(spacing: 10) {
                Text("Nice work!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Now you can compare answers with your partner")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()

            // Invite Partner Button
            VStack(spacing: 20) {
                // Check if currentUser is not nil and handle safely
                if let currentUser = profileViewModel.currentUser {
                    if currentUser.isPartnerMode {
                        // Show buttons when in partner mode
                        Button(action: {
                            
                        }) {
                            Text("Yes")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        NavigationLink {
                            MainView()
                        } label: {
                            Text("Not now")
                                .foregroundColor(.black)
                        }
                    } else {
                        // Show default invite buttons
                        NavigationLink {
                            InvitePartnerView()
                        } label: {
                            Text("Invite my partner")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }

                        
                        NavigationLink {
                            MainView()
                        } label: {
                            Text("Not now")
                                .foregroundColor(.black)
                        }
                    }
                } else {
                    // Show a loading state if currentUser is nil
                    Text("Loading user information...")
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            profileViewModel.fetchCurrentUser()
        }
    }
}

#Preview {
    CompareView()
}
