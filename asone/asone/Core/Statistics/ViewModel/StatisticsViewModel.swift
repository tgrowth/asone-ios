//
//  StatisticsViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import SwiftUI

struct CycleHistory: Identifiable {
    let id = UUID()
    let firstDay: String
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
    @Published var history: [CycleHistory] = [
        CycleHistory(firstDay: "26 Sep 2024", length: 6, cycle: 29, isExpected: true),
        CycleHistory(firstDay: "26 Aug 2024", length: 6, cycle: 31, isExpected: false),
        CycleHistory(firstDay: "31 Jul 2024", length: 6, cycle: 26, isExpected: false),
        CycleHistory(firstDay: "2 Jul 2024", length: 6, cycle: 28, isExpected: false),
        CycleHistory(firstDay: "2 Jun 2024", length: 6, cycle: 30, isExpected: false),
        CycleHistory(firstDay: "6 May 2024", length: 6, cycle: 25, isExpected: false),
    ]
    
    // Predictions data
    @Published var predictions: [CyclePrediction] = [
        CyclePrediction(date: "26 Oct 2024", predictedCycle: 29),
        CyclePrediction(date: "26 Nov 2024", predictedCycle: 30),
        CyclePrediction(date: "26 Dec 2024", predictedCycle: 28),
        CyclePrediction(date: "26 Jan 2025", predictedCycle: 29),
        CyclePrediction(date: "26 Feb 2025", predictedCycle: 31),
        CyclePrediction(date: "26 Mar 2025", predictedCycle: 30),
    ]
}
