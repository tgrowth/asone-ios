//
//  QuizViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz]
    @Published var currentQuiz: Quiz? = nil
    @Published var currentQuestionIndex: Int = 0
    
    init() {
        // Sample data
        let quiz1 = Quiz(name: "Love Language Quiz", isComplete: false, questions: [
            Question(text: "It's more meaningful to me when...", choices: [
                "My partner surprises me with a thoughtful gift",
                "My partner helps me with a task without being asked"
            ]),
            Question(text: "It's more meaningful to me when...", choices: [
                "My partner and I have a deep, uninterrupted conversation",
                "My partner gives me a hug or holds my hand"
            ])
        ])
        
        self.quizzes = [quiz1]
    }
    
    // Start a quiz
    func startQuiz(_ quiz: Quiz) {
        currentQuiz = quiz
        currentQuestionIndex = 0
    }
    
    // Select a choice for the current question
    func selectChoice(at index: Int) {
        currentQuiz?.questions[currentQuestionIndex].selectedChoice = index
    }
    
    // Go to the next question
    func nextQuestion() {
        if let quiz = currentQuiz, currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            completeQuiz()
        }
    }
    
    // Go back to the previous question
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    // Mark the quiz as complete
    private func completeQuiz() {
        currentQuiz?.isComplete = true
        // Handle completion (e.g., show results or navigate back)
    }
}
