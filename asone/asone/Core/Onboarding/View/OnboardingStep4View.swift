//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep4View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("How long is your cycle?")
                .font(.headline)
            
            Picker("Days", selection: $viewModel.userData.cycleLength) {
                ForEach(21..<41) { days in
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
    OnboardingStep4View(viewModel: OnboardingViewModel())
}
