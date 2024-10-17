import Foundation

struct QuizResultResponse: Codable {
    //let isComplete: Bool
    let quizResult: [String: Double]
}

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz?
    @Published var currentQuestionIndex: Int = 0
    @Published var fetchedQuizResults: [String: Double] = [:]
    @Published var quizResult: [String: Double] = ["Words of Affirmation": 0,
                                                   "Acts of Service": 0,
                                                   "Receiving Gifts": 0,
                                                   "Quality Time": 0,
                                                   "Physical Touch": 0]
    
    init() {
        loadQuiz()
    }

    // Load quiz data from quiz-data.json
    func loadQuiz() {
        if let path = Bundle.main.path(forResource: "quiz-data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let quizzes = try decoder.decode([Quiz].self, from: data)
                self.quizzes = quizzes
            } catch {
                print("Error loading quiz data: \(error)")
            }
        } else {
            print("quiz-data.json file not found")
        }
    }

    func startQuiz(_ quiz: Quiz) {
        currentQuiz = quiz
    }

    func selectChoice(at index: Int) {
        currentQuiz?.questions[currentQuestionIndex].selectedOption = index
    }
    
    func nextQuestion() {
        if currentQuestionIndex < currentQuiz!.questions.count - 1 {
            currentQuestionIndex += 1
        }
    }
    
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    func completeQuiz() {
        guard let quiz = currentQuiz else { return }
        
        for question in quiz.questions {
            if let selectedOption = question.selectedOption {
                let questionId = question.id
                updateScore(for: questionId, selectedOption: selectedOption)
            }
        }
        
        currentQuiz?.isComplete = true
        
        UserService.shared.getCurrentUserId { userId in
            if let userId = userId {
                self.saveQuizResults(userId: userId)
            } else {
                print("Error: User ID not found")
            }
        }
    }
    
    func calculateScore(_ quizResult: [String: Double]) -> [String: Double] {
        guard let quiz = currentQuiz else { return [:] }
        
        // Total number of questions in the quiz
        let totalQuestions = quiz.questions.count
        
        // Convert each result count to a percentage
        let percentages: [String: Double] = quizResult.mapValues { count in
            return (Double(count) / Double(totalQuestions)) * 100
        }
        
        return percentages
    }

    private func updateScore(for questionId: Int, selectedOption: Int) {
        guard let guide = currentQuiz?.scoringGuide else { return }
        
        if guide.wordsOfAffirmation.contains(questionId) {
            quizResult["Words of Affirmation", default: 0] += 1
        }
        if guide.actsOfService.contains(questionId) && selectedOption == 1 {
            quizResult["Acts of Service", default: 0] += 1
        }
        if guide.receivingGifts.contains(questionId) && selectedOption == 0 {
            quizResult["Receiving Gifts", default: 0] += 1
        }
        if guide.qualityTime.contains(questionId) && selectedOption == 1 {
            quizResult["Quality Time", default: 0] += 1
        }
        if guide.physicalTouch.contains(questionId) && selectedOption == 1 {
            quizResult["Physical Touch", default: 0] += 1
        }
    }
    
    func saveQuizResults(userId: Int) {
        guard let url = URL(string: "http://localhost:3000/love_languages_results/\(userId)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let resultData: [String: Any] = [
            "user_id": userId,
            "quiz_id": currentQuiz?.id ?? 0,
            //"isComplete": currentQuiz?.isComplete ?? true,
            "quizResult": calculateScore(quizResult)
        ]
        
        do {
            // Encode the result data into JSON
            let jsonData = try JSONSerialization.data(withJSONObject: resultData, options: [])
            
            // Set the request body
            request.httpBody = jsonData
            
            // Send the request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error saving quiz results: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print(resultData)
                        print("Quiz results saved successfully!")
                    } else {
                        print("Failed to save quiz results, status code: \(httpResponse.statusCode)")
                    }
                }
            }
            
            task.resume()
            
        } catch {
            print("Error encoding quiz results: \(error)")
        }
    }
    
    func getQuizResults(userId: Int) {
        guard let url = URL(string: "http://localhost:3000/love_languages_results/\(userId)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching quiz results: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            // Decode the returned data into a dictionary
            do {
                let decoder = JSONDecoder()
                let quizResultResponse = try decoder.decode(QuizResultResponse.self, from: data)
                print(quizResultResponse)

                DispatchQueue.main.async {
                    //self?.currentQuiz?.isComplete = quizResultResponse.isComplete
                    self?.fetchedQuizResults = quizResultResponse.quizResult
                }
            } catch {
                print("Error decoding quiz results: \(error)")
            }
        }
        task.resume()
    }

}
