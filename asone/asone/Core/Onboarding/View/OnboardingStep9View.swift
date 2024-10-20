//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep9View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Header(title: "How long is your menstrual cycle?")
            
            Picker("Days", selection: $viewModel.userData.periodLength) {
                ForEach(1..<31) { days in
                    Text("\(days) days").tag(days)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
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
    OnboardingStep9View(viewModel: OnboardingViewModel())
}
