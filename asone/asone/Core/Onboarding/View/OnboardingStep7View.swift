//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep7View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("Partner Mode")
                .font(.headline)
            
            Picker("", selection: $viewModel.userData.isPartnerMode) {
                Text("Invite partner").tag(true)
                Text("I'm not interested").tag(false)
            }
            .pickerStyle(.segmented)
            
            if viewModel.userData.isPartnerMode {
                VStack(spacing: 16) {                    
                    Text("\(viewModel.userData.inviteCode)")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Button(action: {
                        
                    }) {
                        HStack {
                            Text("Share invite code").foregroundColor(.white)
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                }
                .padding()
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
    OnboardingStep7View(viewModel: OnboardingViewModel())
}
