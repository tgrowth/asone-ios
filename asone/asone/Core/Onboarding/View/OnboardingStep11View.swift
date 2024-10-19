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
            Text("Do you know your last period?")
                .font(.headline)
            
            DatePicker("", selection: $viewModel.userData.lastPeriodDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
            
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
