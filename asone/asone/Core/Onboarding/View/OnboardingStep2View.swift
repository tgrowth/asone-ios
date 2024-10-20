//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//


import SwiftUI

struct OnboardingStep2View: View {
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
            Header(title: "Nice to meet you,")
            
            Text("\(viewModel.userData.username ?? "") 🌷")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
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
    OnboardingStep2View(viewModel: OnboardingViewModel())
}
