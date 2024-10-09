//
//  QuizDetailView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import SwiftUI

struct QuizDetailView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        if let currentQuiz = viewModel.currentQuiz {
            let currentQuestion = currentQuiz.questions[viewModel.currentQuestionIndex]
            VStack {
                Text(currentQuiz.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(currentQuestion.text)
                    .font(.headline)
                    .padding(.bottom, 20)
                
                ForEach(currentQuestion.choices.indices, id: \.self) { index in
                    HStack(alignment: .center) {
                        RadioButton(isSelected: viewModel.currentQuiz?.questions[viewModel.currentQuestionIndex].selectedChoice == index)
                        
                        Text(currentQuestion.choices[index])
                            .frame(maxWidth: .infinity, alignment: .leading)  // Ensure the text aligns to the left
                            .onTapGesture {
                                viewModel.selectChoice(at: index)
                            }
                    }
                    .padding(8)
                }

                Spacer()
                
                HStack {
                    Button(action: {
                        viewModel.previousQuestion()
                    }) {
                        Text("Back").foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.nextQuestion()
                    }) {
                        Text("Next").foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct RadioButton: View {
    var isSelected: Bool
    
    var body: some View {
        Circle()
            .strokeBorder(isSelected ? Color.blue : Color.gray, lineWidth: 2)
            .background(Circle().fill(isSelected ? Color.blue : Color.clear))
            .frame(width: 20, height: 20)
    }
}

#Preview {
    QuizDetailView(viewModel: QuizViewModel())
}
