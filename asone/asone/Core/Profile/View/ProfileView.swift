import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var quizViewModel = QuizViewModel()
    
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(profileViewModel.currentUser?.username ?? profileViewModel.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text(profileViewModel.email) // "Status: Period"
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
                    
                    VStack(spacing: 4) {
                        NavigationLink(destination: InvitePartnerView()) {
                            ProfileOptionRow(icon: "heart", text: "Partner")
                        }
                        
                        NavigationLink(destination: QuizListView(viewModel: QuizViewModel())) {
                            ProfileOptionRow(icon: "list.bullet", text: "Love Languages")
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            ProfileOptionRow(icon: "gearshape", text: "Settings")
                        }
                        
                        NavigationLink(destination: StatisticsView()) {
                            ProfileOptionRow(icon: "chart.bar", text: "Statistics")
                        }
                        
                        Button {
                            showDeleteAlert = true
                        } label: {
                            ProfileOptionRow(icon: "xmark.circle", text: "Delete account")
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
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        Task { await profileViewModel.deleteAccount() }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    ProfileView()
}
