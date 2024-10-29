//
//  PeriodLogService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import Foundation

class PeriodLogService {
    static let shared = PeriodLogService()
    
    func sendPeriodLogs(uid: String, periodLog: PeriodLog) async throws {
        guard let url = URL(string: "\(APIConfig.serverURL)/period_logs/\(uid)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(periodLog)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            print("Logs successfully added for user \(uid).")
        }
    }
}
