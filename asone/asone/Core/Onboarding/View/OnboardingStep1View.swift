//
//  OnboardingStep1View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep1View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Are you using AsOne for yourself?")
                .font(.headline)
            
            Picker("", selection: $viewModel.userData.isUsingForSelf) {
                Text("Yes").tag(true)
                Text("No, I have a code").tag(false)
            }
            .pickerStyle(.segmented)
            
            if !viewModel.userData.isUsingForSelf {
                CustomTextField(placeholder: "Enter your code", text: $viewModel.userData.code)
            }
            
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
