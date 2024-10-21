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
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            Header(title: "What would you like AsOne to call you?")
            
            CustomTextField(placeholder: "", text: $viewModel.userData.username)
            
            Spacer()
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    if !viewModel.userData.username.isEmpty {
                        viewModel.goToNextStep()
                    }
                }
            )
            .disabled(viewModel.userData.username.isEmpty)
            .opacity(viewModel.userData.username.isEmpty ? 0.5 : 1.0)
        }
        .padding()
    }
}

#Preview {
    OnboardingStep1View(viewModel: OnboardingViewModel())
}
