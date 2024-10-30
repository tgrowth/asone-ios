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
        NavigationView {
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
    }

    func checkUserStatus() {
        if let user = authService.userSession {
            UserService.shared.fetchUserData(uid: user.uid) { userData in
                DispatchQueue.main.async {
                    if let userData = userData {
                        self.showOnboarding = !userData.isComplete
                    } else {
                        self.showOnboarding = true
                    }
                    self.isLoading = false
                }
            }
        } else {
            self.isLoading = false
        }
    }
}


#Preview {
    ContentView()
}
