//
//  ContentView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        Group {
            if let _ = contentViewModel.userSession {
                if ((profileViewModel.currentUser?.isComplete) != nil) {
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
