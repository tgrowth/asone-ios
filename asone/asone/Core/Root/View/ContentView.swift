//
//  ContentView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var showOnboarding: Bool = false
    @State private var isLoading: Bool = true
    @ObservedObject private var authService = AuthService.shared

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else if authService.userSession != nil {
                if showOnboarding {
                    OnboardingMainView()
                } else {
                    MainView()
                }
            } else {
                TermsView()
            }
        }
        .onAppear {
            checkUserStatus()
        }
    }

    func checkUserStatus() {
        isLoading = true

        if UserDefaults.standard.bool(forKey: "onboardingComplete") {
            // If onboarding is marked complete in UserDefaults, skip backend check
            self.showOnboarding = false
            self.isLoading = false
            return
        }

        if let user = authService.userSession {
            // Check backend for existing user data if onboardingComplete is unset or false
            UserService.shared.fetchUserData(uid: user.uid) { userData in
                DispatchQueue.main.async {
                    if userData != nil {
                        // User data exists, skip onboarding
                        self.showOnboarding = false
                        UserDefaults.standard.set(true, forKey: "onboardingComplete")
                    } else {
                        // No user data, show onboarding
                        self.showOnboarding = true
                    }
                    self.isLoading = false
                }
            }
        } else {
            // No authenticated session, show TermsView
            self.isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
