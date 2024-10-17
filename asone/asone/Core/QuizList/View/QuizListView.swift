//
//  QuizDetailView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import SwiftUI

struct QuizListView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var showingQuizResult: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.quizzes.indices, id: \.self) { index in
                    let quiz = viewModel.quizzes[index]
                    HStack {
                        Text(quiz.title)
                        Spacer()
                        
                        // Re-start or Start button
                        Text(quiz.isComplete ? "Re-start" : "Start")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                viewModel.startQuiz(quiz)
                            }
                        
                        // View button (only if quiz is completed)
                        if quiz.isComplete {
                            Button(action: {
                                showingQuizResult = true
                            }) {
                                Text("View")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Quizzes")
            .navigationDestination(isPresented: Binding<Bool>(
                get: { viewModel.currentQuiz != nil && !showingQuizResult },
                set: { if !$0 { viewModel.currentQuiz = nil } }
            )) {
                if let currentQuiz = viewModel.currentQuiz {
                    QuizDetailView(viewModel: viewModel)
                }
            }
            .navigationDestination(isPresented: $showingQuizResult) {
                if let currentQuiz = viewModel.currentQuiz {
                    QuizResultView(quizResult: viewModel.fetchedQuizResults)
                }
            }
        }
    }
}

#Preview {
    QuizListView(viewModel: QuizViewModel())
}
