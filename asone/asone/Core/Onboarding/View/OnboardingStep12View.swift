//
//  OnboardingStep12View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep12View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            // Top Icon
            Spacer()
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            // Congratulatory Text
            Text("Great! The more you log, the more accurate AsOne predictions get🌷")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 30)
            
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
    OnboardingStep12View(viewModel: OnboardingViewModel())
}
