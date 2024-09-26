//
//  DashboardView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/26/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }

            // Profile Tab
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text("This is the Home tab.")
                .font(.headline)
        }
        .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            Text("Adjust your preferences here.")
                .font(.headline)
        }
        .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()
            Text("View and update your profile information.")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    MainView()
}
