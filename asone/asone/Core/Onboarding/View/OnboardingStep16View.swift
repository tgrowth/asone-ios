//
//  OnboardingStep16View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep16View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedReason = ""
    
    @State private var navigateToInvitePartner = false
    @State private var navigateToMainView = false

    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                // Title
                Text("Supercharge your lives with AsOne")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Radio buttons
                VStack(alignment: .leading, spacing: 20) {
                    RadioButtonField(id: "why1", label: "Why 1", isMarked: selectedReason == "why1") {
                        self.selectedReason = "why1"
                    }
                    RadioButtonField(id: "why2", label: "Why 1", isMarked: selectedReason == "why2") {
                        self.selectedReason = "why2"
                    }
                    RadioButtonField(id: "why3", label: "Why 3", isMarked: selectedReason == "why3") {
                        self.selectedReason = "why3"
                    }
                }
                .padding(.bottom, 40)
                
                // Bottom Buttons
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
                .padding(.horizontal, 30)
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
                            Text("Done").foregroundColor(.white)
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

struct RadioButtonField: View {
    let id: String
    let label: String
    let isMarked: Bool
    let callback: () -> Void

    var body: some View {
        Button(action: callback) {
            HStack {
                Image(systemName: isMarked ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isMarked ? Color.black : Color.gray)
                Text(label)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview{
    OnboardingStep16View(viewModel: OnboardingViewModel())
}
