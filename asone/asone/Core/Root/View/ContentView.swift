//
//  ContentView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @State private var showOnboarding: Bool = false
    @State private var isLoading: Bool = true
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else if isLoggedIn {
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
    
    // Function to check login and onboarding status
    func checkUserStatus() {
        if let user = Auth.auth().currentUser {
            print(user)
            isLoggedIn = true
            
            UserService.shared.fetchIsComplete(uid: user.uid) { user in
                DispatchQueue.main.async {
                    if let user = user {
                        showOnboarding = false
                    } else {
                        showOnboarding = true
                    }
                    isLoading = false
                }
            }
        } else {
            isLoggedIn = false
            isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
