import SwiftUI


struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var quizViewModel = QuizViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(profileViewModel.displayName)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Status: Period")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        NavigationLink(destination: EditProfileView()) {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()

                    // Premium offer section
                    VStack {
                        Text("Make your life with partner more peaceful and greatful with AsOne Premium")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .padding()
                        
                        NavigationLink(destination: PremiumView()) {
                            Text("Join premium")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Other menu options
                    VStack(spacing: 8) {
                        NavigationLink(destination: InvitePartnerView()) {
                            ProfileOptionRow(icon: "heart", text: "Invite partner")
                        }
                        
                        NavigationLink(destination: QuizListView(viewModel: QuizViewModel())) {
                            ProfileOptionRow(icon: "list.bullet", text: "Re-Test Love Languages")
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            ProfileOptionRow(icon: "gearshape", text: "Settings")
                        }
                        
                        NavigationLink(destination: StatisticsView()) {
                            ProfileOptionRow(icon: "chart.bar", text: "Statistics")
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct ProfileOptionRow: View {
    var icon: String
    var text: LocalizedStringKey
    var iconColor: Color = .black
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
            Text(text)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}


#Preview {
    ProfileView()
}
