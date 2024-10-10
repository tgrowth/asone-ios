import SwiftUI

struct QuizDetailView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var quizCompleted = false
    
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                        if viewModel.currentQuestionIndex == currentQuiz.questions.count - 1 {
                            // viewModel.completeQuiz()
                            print("Complete")
                            quizCompleted = true // Set quizCompleted to true
                        } else {
                            viewModel.nextQuestion()
                        }
                    }) {
                        Text(viewModel.currentQuestionIndex == currentQuiz.questions.count - 1 ? "Complete" : "Next")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // NavigationLink to redirect to the result view after quiz is complete
                NavigationLink(destination: QuizResultView(), isActive: $quizCompleted) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden()
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
            .frame(width: 16, height: 16)
    }
}

#Preview {
    QuizDetailView(viewModel: QuizViewModel())
}
