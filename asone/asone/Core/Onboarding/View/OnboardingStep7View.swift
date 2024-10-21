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
            
            Header(title: "Got it! We’ll help you with:")
            
            VStack(alignment: .leading, spacing: 15) {
                BulletPoint(text: "Understanding and tracking your cycle with ease")
                BulletPoint(text: "Managing your emotions and symptoms effectively")
                BulletPoint(text: "Improving communication and intimacy with your partner")
                BulletPoint(text: "Learning what your body is telling you about your health and well-being")
                BulletPoint(text: "Receiving personalized tips to enhance your well-being, tailored just for you")
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
    OnboardingStep7View(viewModel: OnboardingViewModel())
}
