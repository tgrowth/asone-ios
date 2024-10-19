//
//  OnboardingStep7View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep7View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("Got it! We’ll help you with:")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 15) {
                OnboardingBulletPoint(text: "Understanding and tracking your cycle with ease")
                OnboardingBulletPoint(text: "Managing your emotions and symptoms effectively")
                OnboardingBulletPoint(text: "Improving communication and intimacy with your partner")
                OnboardingBulletPoint(text: "Learning what your body is telling you about your health and well-being")
                OnboardingBulletPoint(text: "Receiving personalized tips to enhance your well-being, tailored just for you")
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
        .padding(.vertical)
    }
}

// A reusable view for each bullet point
struct OnboardingBulletPoint: View {
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 12, height: 12)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    OnboardingStep7View(viewModel: OnboardingViewModel())
}
