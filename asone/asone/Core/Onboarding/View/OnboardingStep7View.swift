//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep7View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("Partner Mode")
                .font(.headline)
            
            Picker("", selection: $viewModel.userData.isPartnerMode) {
                Text("Invite partner").tag(true)
                Text("I'm not interested").tag(false)
            }
            .pickerStyle(.segmented)
            
            if viewModel.userData.isPartnerMode {
                CustomTextField(placeholder: "Enter your partner's email", text: $viewModel.userData.partnerEmail)
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
    OnboardingStep7View(viewModel: OnboardingViewModel())
}
