//
//  QuizDetailView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import SwiftUI

struct QuizListView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.quizzes.indices, id: \.self) { index in
                    let quiz = viewModel.quizzes[index]
                    HStack {
                        Text(quiz.title)
                        Spacer()
                        Text(quiz.isComplete ? "Re-start" : "Start")
                            .onTapGesture {
                                viewModel.startQuiz(quiz)
                            }
                    }
                }
            }
            .navigationTitle("Quizzes")
            .navigationDestination(isPresented: Binding<Bool>(
                get: { viewModel.currentQuiz != nil },
                set: { if !$0 { viewModel.currentQuiz = nil } }
            )) {
                if let currentQuiz = viewModel.currentQuiz {
                    QuizDetailView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    QuizListView(viewModel: QuizViewModel())
}
