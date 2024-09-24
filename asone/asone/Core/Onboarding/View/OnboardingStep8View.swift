//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep8View: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Partner Invite Code")
                .font(.headline)
            
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
    OnboardingStep8View(viewModel: OnboardingViewModel())
}
