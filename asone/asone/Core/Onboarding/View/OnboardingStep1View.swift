//
//  OnboardingStep1View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep1View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            // Top Icon
            Spacer()
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            Text("What would you like AsOne call you?")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 30)
            
            CustomTextField(placeholder: "", text: $viewModel.userData.code) //change***
            
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
    OnboardingStep1View(viewModel: OnboardingViewModel())
}
