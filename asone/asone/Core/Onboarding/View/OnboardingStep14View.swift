//
//  OnboardingStep14View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep14View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedEmotionLevel: Double = 3.0
    
    var body: some View {
        VStack {
            Header(title: "\(viewModel.userData.username), how are you feeling today?")

            // Slider with user avatar
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 200, height: 200)
                    
                    // This is where the draggable icon would go
                    Image("userAvatar") // Replace with actual user image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .offset(x: CGFloat(selectedEmotionLevel * 10 - 50)) // Adjust position
                }
                
                // Slider Control
                Slider(value: $selectedEmotionLevel, in: 0...5, step: 1)
                    .padding()
                    .accentColor(.gray)
            }
            
            Spacer()
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.userData.mood = selectedEmotionLevel
                    
                    viewModel.goToNextStep()
                }
            )
        }.padding()
    }
}

#Preview {
    OnboardingStep14View(viewModel: OnboardingViewModel())
}
