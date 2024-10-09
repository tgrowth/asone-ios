import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
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
