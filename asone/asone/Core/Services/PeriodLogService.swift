//
//  PeriodLogService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import Foundation

class PeriodLogService {
    static let shared = PeriodLogService()
    
    func sendPeriodLogs(periodLog: PeriodLog) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)/period_logs/") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(periodLog)
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            print("Logs successfully added for user.")
        }
    }
    
    func fetchPeriodLogs(uid: String) async throws -> PeriodLog {
        guard let url = URL(string: "\(APIConfig.baseURL)/period_logs/\(uid)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw URLError(.badServerResponse)
        }

        do {
            let periodLog = try JSONDecoder().decode(PeriodLog.self, from: data)
            return periodLog
        } catch {
            print("Failed to decode PeriodLog: \(error)")
            throw error
        }
    }
}
