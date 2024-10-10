import SwiftUI

struct QuizDetailView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var quizCompleted = false
    
    var body: some View {
        if let currentQuiz = viewModel.currentQuiz {
            let currentQuestion = currentQuiz.questions[viewModel.currentQuestionIndex]
            
            VStack {
                // Progress Bar
                ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(currentQuiz.questions.count))
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.black))
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                // Question Counter
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(currentQuiz.questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                
                // Question Text
                Text(currentQuestion.text)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                
                // Choices
                VStack(spacing: 12) {
                    ForEach(currentQuestion.choices.indices, id: \.self) { index in
                        Text(currentQuestion.choices[index])
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.currentQuiz?.questions[viewModel.currentQuestionIndex].selectedChoice == index ? Color.gray.opacity(0.5) : Color(UIColor.systemGray5))
                            .cornerRadius(12)
                            .onTapGesture {
                                viewModel.selectChoice(at: index)
                            }
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                // Bottom Controls (Back and Next Buttons)
                HStack {
                    // Back Button
                    Button(action: {
                        viewModel.previousQuestion()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    // Next Button
                    // Next Button
                    Button(action: {
                        if viewModel.currentQuestionIndex == currentQuiz.questions.count - 1 {
                            quizCompleted = true
                            viewModel.completeQuiz()
                            
                            if let quizResult = viewModel.prepareQuizResult() {
                                viewModel.sendQuizResult(quizResult) { success in
                                    if success {
                                        print("Quiz result saved successfully.")
                                    } else {
                                        print("Failed to save quiz result.")
                                    }
                                }
                            }
                            
                        } else {
                            viewModel.nextQuestion()
                        }
                    }) {
                        Text(viewModel.currentQuestionIndex == currentQuiz.questions.count - 1 ? "Complete" : "Next")
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)

                }
                .padding(.bottom, 20)
                
                // Navigation to Result View after quiz completion
                NavigationLink(destination: QuizResultView(), isActive: $quizCompleted) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    QuizDetailView(viewModel: QuizViewModel())
}
