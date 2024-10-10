//
//  QuizViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/8/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz? = nil
    @Published var currentQuestionIndex: Int = 0
    
    init() {
        loadQuizzes()
    }
    
    func loadQuizzes() {
        if let url = Bundle.main.url(forResource: "quiz-data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let loadedQuizzes = try decoder.decode([Quiz].self, from: data)
                self.quizzes = loadedQuizzes
            } catch {
                print("Error loading quizzes: \(error)")
            }
        } else {
            print("quiz-data.json file not found")
        }
    }
    
    func startQuiz(_ quiz: Quiz) {
        currentQuiz = quiz
        currentQuestionIndex = 0
    }
    
    // Select a choice for the current question
    func selectChoice(at index: Int) {
        currentQuiz?.questions[currentQuestionIndex].selectedChoice = index
    }
    
    func nextQuestion() {
        if let quiz = currentQuiz, currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            completeQuiz()
        }
    }
    
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    func completeQuiz() {
        currentQuiz?.isComplete = true
        
        if let quizResult = prepareQuizResult() {
            sendQuizResult(quizResult) { success in
                if success {
                    print("Quiz result saved successfully.")
                } else {
                    print("Failed to save quiz result.")
                }
            }
        }        
    }
    
    func prepareQuizResult() -> QuizResult? {
        guard let currentQuiz = currentQuiz else { return nil }
        
        let answers = currentQuiz.questions.compactMap { question in
            if let selectedChoiceIndex = question.selectedChoice {
                return Answer(question: question.text, selectedChoice: question.choices[selectedChoiceIndex])
            }
            return nil
        }
        
        let result = QuizResult(
            quizName: currentQuiz.name,
            userId: "4", // replace with uid
            answers: answers
        )
        
        return result
    }

    
    private func sendQuizResult(_ result: QuizResult, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://api.asone.life/quiz/results") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(result)
            request.httpBody = jsonData
        } catch {
            print("Error encoding quiz result: \(error)")
            completion(false)
            return
        }
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            completion(true)
        }
        
        task.resume()
    }
}
