//
//  OnboardingStep6View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep6View: View {
    @State private var selectedOption: String? = nil
    @ObservedObject var viewModel: OnboardingViewModel

    
    let options = [
        "To track my menstrual cycle and stay informed",
        "To understand my emotions and symptoms better",
        "To improve communication and intimacy with my partner",
        "To plan for pregnancy or manage contraception",
        "Something else"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Header(title: "What brings you to AsOne?")
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        Text(option)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
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
    OnboardingStep4View(viewModel: OnboardingViewModel())
}
