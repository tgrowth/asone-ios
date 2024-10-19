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
            case .start:
                OnboardingStartView(viewModel: viewModel)
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
            case .step8:
                OnboardingStep8View(viewModel: viewModel)
            case .step9:
                OnboardingStep9View(viewModel: viewModel)
            case .step10:
                OnboardingStep10View(viewModel: viewModel)
            case .step11:
                OnboardingStep11View(viewModel: viewModel)
            case .step12:
                OnboardingStep12View(viewModel: viewModel)
            case .step13:
                OnboardingStep13View(viewModel: viewModel)
            case .step14:
                OnboardingStep14View(viewModel: viewModel)
            case .step15:
                OnboardingStep15View(viewModel: viewModel)
            case .step16:
                OnboardingStep16View(viewModel: viewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
}


#Preview {
    OnboardingMainView(viewModel: OnboardingViewModel())
}
