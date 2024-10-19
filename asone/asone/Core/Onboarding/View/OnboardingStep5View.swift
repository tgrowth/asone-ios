//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep5View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("Set your date of birth")
                .font(.headline)
            
            DatePicker("", selection: $viewModel.userData.birthday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
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
    OnboardingStep5View(viewModel: OnboardingViewModel())
}
