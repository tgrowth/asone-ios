//
//  CalendarView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/24/24.
//

import Foundation
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date = Date()
    @Published var selectedDate: Date?
    @Published var displayedMonth: Date = Date()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let calendar = Calendar.current

    // Get all days for the displayed month
    func daysForMonth() -> [Date] {
        let range = calendar.range(of: .day, in: .month, for: displayedMonth)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!

        return range.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

    // Get day for a given date
    func dayString(for date: Date) -> String {
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }

    // Move to the previous month
    func previousMonth() {
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) {
            displayedMonth = previousMonth
        }
    }

    // Move to the next month
    func nextMonth() {
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) {
            displayedMonth = nextMonth
        }
    }

    // Check if a date is today
    func isToday(_ date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }

    // Check if a date is selected
    func isSelected(_ date: Date) -> Bool {
        guard let selectedDate = selectedDate else { return false }
        return calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    // Asynchronous function to add period logs
    @MainActor
    func addPeriodLogs(uid: String) async {
        isLoading = true
        errorMessage = nil
        
        guard let selectedDate = selectedDate else {
            self.errorMessage = "No date selected"
            isLoading = false
            return
        }
        
        let periodLog = PeriodLog(uid: uid, startDates: [selectedDate.toString()])
        
        do {
            try await PeriodLogService.shared.sendPeriodLogs(periodLog: periodLog)
            print("Logs successfully added for user \(uid).")
        } catch {
            self.errorMessage = "Failed to add logs: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
