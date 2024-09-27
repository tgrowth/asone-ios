//
//  ContentView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel() // Assuming this handles session
    @StateObject var onboardingViewModel = OnboardingViewModel() // Onboarding state
    
    var body: some View {
        Group {
            if let _ = contentViewModel.userSession {
                if onboardingViewModel.userData.isComplete {
                    MainView()
                } else {
                    OnboardingMainView(viewModel: onboardingViewModel)
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
