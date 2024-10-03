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
                    Label("", systemImage: "house.fill")
                }

            // Profile Tab
            ProfileView()
                .tabItem {
                    Label("", systemImage: "person.fill")
                }
        }.tint(.black)
    }
}


#Preview {
    MainView()
}
