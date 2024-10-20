//
//  OnboardingStartView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//


import SwiftUI

struct OnboardingStartView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Header(title: "Let's get to know you better!")
            
            Text("We’ll ask a few questions to personalize your experience and provide the most accurate insights and tips. Ready?")
                .multilineTextAlignment(.center)
            
            //for signout purposes***
            Button {
                AuthService.shared.signOut()
            } label: {
                Text("Sign out")
            }

            
            Spacer()
            
            HStack {
                OnboardingNavigation(
                    showBack: false,
                    showNext: false,
                    backAction: viewModel.goToPreviousStep
                ) {}
                
                Button(action: {
                    viewModel.goToNextStep()
                }) {
                    HStack {
                        Text("Start").foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingStartView(viewModel: OnboardingViewModel())
}
