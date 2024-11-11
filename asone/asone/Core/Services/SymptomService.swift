//
//  SymptomService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/24/24.
//


import Foundation

class SymptomService {
    static let shared = SymptomService()
    
    func fetchSymptoms() async throws -> [Symptom] {
        guard let url = URL(string: "\(APIConfig.baseURL)/symptom_logs") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let json = try JSONDecoder().decode([String: [Symptom]].self, from: data)
        return json["symptoms"] ?? []
    }
    
    func sendSymptomLog(_ symptomLog: SymptomLog) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)/symptom_logs") else {
            throw URLError(.badURL)
        }
        
        // Encode the SymptomLog to JSON
        let jsonData = try JSONEncoder().encode(["symptomLog": symptomLog])
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Perform the request
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // Check for a successful response (status code 200)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 200 || httpResponse.statusCode > 201 {
            print(httpResponse)
            throw URLError(.badServerResponse)
        }
    }
    
    func fetchSymptomsForDate(uid: String, date: String) async throws -> SymptomLog {
        guard let url = URL(string: "\(APIConfig.baseURL)/symptom_logs/\(uid)/\(date)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the response
        let decodedResponse = try JSONDecoder().decode([String: SymptomLog].self, from: data)
        
        // Access the symptomLog from the response
        guard let symptomLog = decodedResponse["symptomLog"] else {
            throw URLError(.badServerResponse)
        }
    
        return symptomLog
    }

}
