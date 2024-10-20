//
//  OnboardingStep1View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep4View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Header(title: "Are you using AsOne for yourself?")
            
            VStack(alignment: .leading, spacing: 15) {
                BulletOption(title: "Yes", isSelected: viewModel.userData.isUsingForSelf) {
                    viewModel.userData.isUsingForSelf = true
                }
                
                BulletOption(title: "No, I have a code", isSelected: !viewModel.userData.isUsingForSelf) {
                    viewModel.userData.isUsingForSelf = false
                }
            }
            
            if !viewModel.userData.isUsingForSelf {
                CustomTextField(placeholder: "Enter your code", text: $viewModel.userData.code)
                    .padding(.top, 10)
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

struct BulletOption: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                    .foregroundColor(isSelected ? .black : .gray)
                Text(title)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OnboardingStep4View(viewModel: OnboardingViewModel())
}
