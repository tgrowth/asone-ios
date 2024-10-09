import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Cycle Overview (existing component)
                    VStack(alignment: .leading) {
                        Text("Your Cycle")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text("Day 14 of 28-day cycle")
                            .font(.subheadline)
                        ProgressView(value: 14, total: 28)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // "My Quizzes" Dashboard Section
                    NavigationLink(destination: QuizListView(viewModel: QuizViewModel())) {
                        VStack(alignment: .leading) {
                            Text("My Quizzes")
                                .font(.headline)
                                .padding(.bottom, 2)
                            Text("View and manage your quizzes")
                                .font(.subheadline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    // Health Metrics (existing component)
                    VStack(alignment: .leading) {
                        Text("Health Overview")
                            .font(.headline)
                            .padding(.bottom, 2)
                        HStack {
                            VStack {
                                Text("Steps")
                                Text("6,500")
                                    .font(.title)
                            }
                            Spacer()
                            VStack {
                                Text("Sleep")
                                Text("7 hrs")
                                    .font(.title)
                            }
                            Spacer()
                            VStack {
                                Text("Heart Rate")
                                Text("72 BPM")
                                    .font(.title)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Other components (Daily Tips, Calendar, etc.)
                    // ...

                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
