import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .home
    @State private var isExpanded = false
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var partnerViewModel = PartnerViewModel()
    
    
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
                case .stats:
                    PartnerView(viewModel: partnerViewModel)
                case .partner:
                    if profileViewModel.currentUser!.partnerMode {
                        PartnerView(viewModel: partnerViewModel)
                    } else {
                        InvitePartnerView()
                    }
                case .account:
                    ProfileView()
                }

                Spacer()

                // Custom Tab Bar
                ZStack {
                    HStack {
                        Spacer()

                        // Home Button
                        TabBarItem(icon: "drop", label: "home", selectedTab: $selectedTab)
                        Spacer()

                        // Calendar Button
                        TabBarItem(icon: "calendar", label: "calendar", selectedTab: $selectedTab)
                        Spacer()

                        // Partner Button
                        TabBarItem(icon: "heart", label: "partner", selectedTab: $selectedTab)
                        Spacer()

                        // Profile Button
                        TabBarItem(icon: "person", label: "account", selectedTab: $selectedTab)
                        Spacer()
                    }
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black) // Dark gray tab bar background
                            .shadow(radius: 10)
                    )
                    .padding(.horizontal)

                    // Center Button with Expandable Options
                    VStack {
                        if isExpanded {
                            // Additional options displayed above the center button
                            HStack(spacing: 40) {
                                // Button 1
                                OptionButton(icon: "drop.fill") {
                                    // Action for Log Period
                                    isExpanded = false
                                }

                                // Button 2
                                OptionButton(icon: "chart.pie.fill") {
                                    // Action for Cycle Advice
                                    isExpanded = false
                                    selectedTab = .stats
                                }

                                // Button 3
                                OptionButton(icon: "square.and.pencil") {
                                    // Action for Add Symptoms
                                    isExpanded = false
                                    selectedTab = .add
                                }
                            }
                            .offset(y: -55) // Position the expanded buttons above the center button
                            .transition(.scale)
                        }

                        // Plus/X Button (Center)
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle() // Toggle expand/collapse of buttons
                            }
                        }) {
                            Image(systemName: isExpanded ? "xmark" : "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.black) // Black circle background
                                        .frame(width: 50, height: 50)
                                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                                )
                        }
                        .offset(y: -40) // Push the button up for emphasis
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

// Tab Enum to switch between different tabs
enum Tab {
    case home
    case calendar
    case add
    case partner
    case account
    case stats
}

// TabBarItem view with color adjustments
struct TabBarItem: View {
    var icon: String
    var label: String
    @Binding var selectedTab: Tab
    var tab: Tab {
        switch label {
        case "home": return .home
        case "calendar": return .calendar
        case "partner": return .partner
        case "account": return .account
        default: return .home
        }
    }

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
    }
}

// OptionButton view for expanded center button actions
struct OptionButton: View {
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(Color.gray) // Dark gray background for the expanded option buttons
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                )
        }
    }
}

struct CalendarView: View {
    var body: some View {
        Text("Calendar Screen")
            .navigationTitle("Calendar")
    }
}


#Preview {
    MainView()
}
