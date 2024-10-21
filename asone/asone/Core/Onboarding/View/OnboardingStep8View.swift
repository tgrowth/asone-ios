//
//  OnboardingStep8View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep8View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedOption: String? = nil
    let options = [
        "Version 1 😌",
        "Version 2 😠",
        "Version 3 😕",
        "Version 4 😔"
    ]

    var body: some View {
        VStack {
            Spacer()
            
            Header(title: "How do you feel about your period, \(viewModel.userData.username)?")
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    VStack(alignment: .center, spacing: 10) {
                        Text(option)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        
                        if selectedOption == option {
                            Text(option)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            Spacer()
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.userData.state = selectedOption ?? "Version 1"
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
    }
}

#Preview {
    OnboardingStep8View(viewModel: OnboardingViewModel())
}
