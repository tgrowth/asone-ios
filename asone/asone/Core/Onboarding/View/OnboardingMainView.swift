//
//  OnboardingView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingMainView: View {
    @ObservedObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.currentStep {
            case .step1:
                OnboardingStep1View(viewModel: viewModel)
            case .step2:
                OnboardingStep2View(viewModel: viewModel)
            case .step3:
                OnboardingStep3View(viewModel: viewModel)
            case .step4:
                OnboardingStep4View(viewModel: viewModel)
            case .step5:
                OnboardingStep5View(viewModel: viewModel)
            case .step6:
                OnboardingStep6View(viewModel: viewModel)
            case .step7:
                OnboardingStep7View(viewModel: viewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
}


#Preview {
    OnboardingMainView(viewModel: OnboardingViewModel())
}
