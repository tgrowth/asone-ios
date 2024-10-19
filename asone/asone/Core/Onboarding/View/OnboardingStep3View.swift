//
//  OnboardingStep3View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep3View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedAvatar: Int? = nil
    
    let avatars = Array(1...9) // Simulating 9 avatars
    
    var body: some View {
        VStack {
            // Large Avatar placeholder
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                )
                .padding(.bottom, 30)
            
            // Title
            Text("Choose your avatar")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 30)
            
            // Avatar selection grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 5), spacing: 20) {
                ForEach(avatars, id: \.self) { avatar in
                    Button(action: {
                        selectedAvatar = avatar
                    }) {
                        if selectedAvatar == avatar {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                )
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                // Custom avatar (add button)
                Button(action: {
                    // Handle custom avatar upload
                }) {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        )
                }
            }
            .padding(.bottom, 30)
            
            // Apply Button
            Button(action: {
                // Handle apply action
            }) {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
    }
}

#Preview {
    OnboardingStep3View(viewModel: OnboardingViewModel())
}

