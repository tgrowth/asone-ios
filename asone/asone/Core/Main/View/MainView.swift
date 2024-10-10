//
//  DashboardView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/26/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Render selected view based on tab selection
                switch selectedTab {
                case .home:
                    HomeView()
                case .calendar:
                    CalendarView()
                case .add:
                    SymptomsView()
                case .partner:
                    PartnerView()
                case .account:
                    ProfileView()
                }

                Spacer()

                // Custom Tab Bar
                HStack {
                    Spacer()

                    // Home Button
                    TabBarItem(icon: "drop", label: "home") {
                        selectedTab = .home
                    }

                    Spacer()

                    // Calendar Button
                    TabBarItem(icon: "calendar", label: "calendar") {
                        selectedTab = .calendar
                    }

                    Spacer()

                    // Plus Button (Center)
                    Button(action: {
                        selectedTab = .add
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                            )
                    }
                    .offset(y: -20) // Push the button up for emphasis

                    Spacer()

                    // Partner Button
                    TabBarItem(icon: "heart", label: "partner") {
                        selectedTab = .partner
                    }

                    Spacer()

                    // Profile Button
                    TabBarItem(icon: "person", label: "account") {
                        selectedTab = .account
                    }

                    Spacer()
                }
                .frame(height: 60)
                .background(Color.black.opacity(0.05))
            }
        }
    }
}

// Tab Enum to switch between different tabs
enum Tab {
    case home
    case calendar
    case add
    case partner
    case account
}

struct TabBarItem: View {
    var icon: String
    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
    }
}


struct CalendarView: View {
    var body: some View {
        Text("Calendar Screen")
            .navigationTitle("Calendar")
    }
}

struct SymptomsView: View {
    var body: some View {
        Text("Add Symptoms")
            .navigationTitle("Add Symptoms")
    }
}

struct PartnerView: View {
    var body: some View {
        Text("Partner Screen")
            .navigationTitle("Partner")
    }
}


#Preview {
    MainView()
}
