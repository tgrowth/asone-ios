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
    
    var body: some View {
        Group{
            if contentViewModel.userSession != nil {
                if onboardingViewModel.userData.isComplete {
                    MainView()
                } else {
                    OnboardingMainView()
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
