//
//  StatisticsViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import SwiftUI

struct CycleHistory: Identifiable {
    let id = UUID()
    let startDate: String
    let length: Int
    let cycle: Int
    let isExpected: Bool
}

struct CyclePrediction: Identifiable {
    let id = UUID()
    let date: String
    let predictedCycle: Int
}

class StatisticsViewModel: ObservableObject {
    // Cycle statistics
    @Published var cycleLength: Int = 29
    @Published var periodLength: Int = 6
    
    // History data
    @Published var history: [CycleHistory] = []
    
    // Predictions data (this remains hardcoded as an example)
    @Published var predictions: [CyclePrediction] = [
        CyclePrediction(date: "26 Oct 2024", predictedCycle: 29),
        CyclePrediction(date: "26 Nov 2024", predictedCycle: 30),
        CyclePrediction(date: "26 Dec 2024", predictedCycle: 28),
        CyclePrediction(date: "26 Jan 2025", predictedCycle: 29),
        CyclePrediction(date: "26 Feb 2025", predictedCycle: 31),
        CyclePrediction(date: "26 Mar 2025", predictedCycle: 30),
    ]
    
    @MainActor
    func fetchCycleHistory(uid: String) async {
        do {
            let periodLog = try await PeriodLogService.shared.fetchPeriodLogs(uid: uid)
            
            // Populate the history array with cycle data
            let cycleHistories = periodLog.periodLogs.enumerated().map { index, date in
                CycleHistory(
                    startDate: date,
                    length: self.periodLength,
                    cycle: self.cycleLength,
                    isExpected: index == 0 // Assume the first entry is expected for simplicity
                )
            }
            self.history = cycleHistories
        } catch {
            print("Failed to fetch cycle history: \(error.localizedDescription)")
        }
    }
}
