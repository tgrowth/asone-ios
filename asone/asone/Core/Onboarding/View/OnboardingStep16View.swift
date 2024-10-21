//
//  OnboardingStep16View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep16View: View {
    @ObservedObject var viewModel: OnboardingViewModel    
    @State private var navigateToInvitePartner = false
    @State private var navigateToMainView = false

    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Header(title: "Supercharge your lives with AsOne")
                
                VStack(alignment: .leading, spacing: 20) {
                    BulletPoint(text: "Understanding and tracking your cycle with ease")
                    BulletPoint(text: "Managing your emotions and symptoms effectively")
                    BulletPoint(text: "Improving communication and intimacy with your partner")
                    BulletPoint(text: "Learning what your body is telling you about your health and well-being")
                    BulletPoint(text: "Receiving personalized tips to enhance your well-being, tailored just for you")
                }
                
                VStack(spacing: 20) {
                    Button(action: {
                        // Navigate to InvitePartnerView
                        navigateToInvitePartner = true
                    }) {
                        Text("Invite my partner")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .background(
                        NavigationLink("", destination: InvitePartnerView(), isActive: $navigateToInvitePartner)
                            .hidden()
                    )
                    
                    Button(action: {
                        // Navigate to MainView
                        navigateToMainView = true
                    }) {
                        Text("I'm not interested")
                            .foregroundColor(.gray)
                    }
                    .background(
                        NavigationLink("", destination: MainView(), isActive: $navigateToMainView)
                            .hidden()
                    )
                }
                .padding()
                Spacer()
                
                HStack {
                    OnboardingNavigation(
                        showNext: false,
                        backAction: viewModel.goToPreviousStep
                    ) {}
                    
                    Button(action: {
                        viewModel.completeOnboarding()
                    }) {
                        HStack {
                            Text("Complete").foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10)
                    }
                }
            }.padding()
        }
    }
}

#Preview{
    OnboardingStep16View(viewModel: OnboardingViewModel())
}
