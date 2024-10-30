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
        guard let url = URL(string: "\(APIConfig.serverURL)/symptoms") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let json = try JSONDecoder().decode([String: [Symptom]].self, from: data)
        return json["symptoms"] ?? []
    }
    
    func sendSymptoms(uid: String, symptomId: Int) async throws {
        guard let url = URL(string: "http://localhost:3000/userInfo/\(uid)/symptoms/\(symptomId)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 201 else {
                throw URLError(.badServerResponse)
            }
        }
    }
}
