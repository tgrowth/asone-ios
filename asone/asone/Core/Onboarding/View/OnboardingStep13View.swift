//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep13View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("Are you trying to conceive right now?")
                .font(.headline)
            
            // Custom buttons for selection
            VStack(spacing: 16) {
                Button(action: {
                    viewModel.userData.isTryingToConceive = true
                }) {
                    HStack {
                        Text("Yes, I'm trying to get pregnant")
                            .foregroundColor(viewModel.userData.isTryingToConceive ? .white : .black)
                        Spacer()
                        if viewModel.userData.isTryingToConceive {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.userData.isTryingToConceive ? Color.black : Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }

                Button(action: {
                    viewModel.userData.isTryingToConceive = false
                }) {
                    HStack {
                        Text("No, I just want to track my cycle")
                            .foregroundColor(!viewModel.userData.isTryingToConceive ? .white : .black)
                        Spacer()
                        if !viewModel.userData.isTryingToConceive {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(!viewModel.userData.isTryingToConceive ? Color.black : Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding()

            Spacer()

            // Navigation buttons
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.generateInviteCode()
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
    }
}

#Preview {
    OnboardingStep13View(viewModel: OnboardingViewModel())
}
