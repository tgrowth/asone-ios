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
        "Version 4 😌",
        "Version 5 😔"
    ]

    var body: some View {
        VStack {
            Spacer()
            
            Header(title: "How do you feel about your period, \(viewModel.userData.username)?")
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(option)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        
                        // Show additional information for Version 4 if selected
                        if option == "Version 4 😌" && selectedOption == option {
                            Text("The menstrual cycle can have a significant impact on a woman's physical and emotional well-being, which in turn affects her relationships. Understanding the cyclical changes and how they influence mood, energy levels, and needs helps partners to better support one another.")
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
