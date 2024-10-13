//
//  QuizResultViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/10/24.
//

import Foundation
import Combine
import FirebaseAuth

class QuizResultViewModel: ObservableObject {
    @Published var results: [(category: String, percentage: Int)] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    
    // Fetch quiz results
    func fetchQuizResults() {
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "User not authenticated"
            return
        }
        
        let userId = user.uid
        guard let url = URL(string: "http://api.asone.life/love_languages_results/\(userId)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [String: Int].self, decoder: JSONDecoder())  // Assuming the API returns a dictionary
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] data in
                // Convert data from the API into the view format
                let categories = [
                    "Words of Affirmation",
                    "Acts of Service",
                    "Receiving Gifts",
                    "Quality Time",
                    "Physical Touch"
                ]
                
                // Assuming the API returns something like {"1": 40, "2": 25, ...}
                let sortedResults = data.sorted { $0.value > $1.value }
                self?.results = sortedResults.map { (key, value) in
                    (category: categories[Int(key)! - 1], percentage: value)
                }
            }
            .store(in: &cancellables)
    }
}
