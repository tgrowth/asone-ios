//
//  OnboardingNavigation.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//


import SwiftUI

struct OnboardingNavigation: View {
    var showBack: Bool = true                // Control whether the back button is shown
    var showNext: Bool = true                // Control whether the next button is shown
    var nextIsDisabled: Bool = false         // Disable Next button if necessary
    var backAction: () -> Void               // Action for back button
    var nextAction: () -> Void               // Action for next button

    var body: some View {
        HStack {
            if showBack {
                Button(action: backAction) {
                    Text("Back")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            if showNext {
                Button(action: nextAction) {
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .background(nextIsDisabled ? Color.gray : Color.black)
                        .cornerRadius(8)
                }
                .disabled(nextIsDisabled)  // Disable if validation is needed
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OnboardingNavigation(
        backAction: { print("Back button pressed") },
        nextAction: { print("Next button pressed") }
    )
}

