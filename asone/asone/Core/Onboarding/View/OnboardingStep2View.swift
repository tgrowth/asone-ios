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
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            Header(title: "Nice to meet you, \(viewModel.userData.username) 🌷")

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
