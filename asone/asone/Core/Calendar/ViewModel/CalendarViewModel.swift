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
    @Published var displayedMonth: Date = Date()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedRanges: [(start: Date, end: Date?)] = []
    @Published var periodDates: [Date] = []

    let calendar = Calendar.current

    // Get all days for the displayed month
    func daysForMonth() -> [Date] {
        let range = calendar.range(of: .day, in: .month, for: displayedMonth)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
        
        return range.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
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
    
    func isFuture(_ date: Date) -> Bool {
        return date > Date()
    }

    // Check if a date is within any selected range
    func isSelected(_ date: Date) -> Bool {
        return selectedRanges.contains { date >= $0.start && date <= ($0.end ?? $0.start) }
    }

    // Select or deselect a date to create a range
    func selectDate(_ date: Date) {
        // Check if the date is already selected
        if let rangeIndex = selectedRanges.firstIndex(where: { date >= $0.start && date <= ($0.end ?? $0.start) }) {
            // If the range has both start and end, deselect the entire range
            if selectedRanges[rangeIndex].end != nil {
                selectedRanges.remove(at: rangeIndex)
            } else {
                // If it's a single date (start with no end), remove the start date
                selectedRanges[rangeIndex].end = nil
            }
        } else {
            // If no range is selected or the last range has an end date, start a new range
            if selectedRanges.isEmpty || selectedRanges.last?.end != nil {
                selectedRanges.append((start: date, end: nil))
            } else if let lastRangeIndex = selectedRanges.indices.last, selectedRanges[lastRangeIndex].end == nil {
                // Set end date for the last range if the date is later than the start date
                if date >= selectedRanges[lastRangeIndex].start {
                    selectedRanges[lastRangeIndex].end = date
                } else {
                    // If the selected date is earlier, start a new range
                    selectedRanges.append((start: date, end: nil))
                }
            }
        }
    }
    
    // Generate dates between the start and end date
    private func generateDateRange(from startDate: Date, to endDate: Date) -> [String] {
        var dates: [String] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate.toString())
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
        
        return dates
    }

    // Asynchronous function to add period logs
    @MainActor
    func addPeriodLogs(uid: String) async {
        isLoading = true
        errorMessage = nil
        
        // Generate period logs for each selected range
        let periodLogs: [PeriodLog] = selectedRanges.compactMap { range -> PeriodLog? in
            guard let end = range.end else { return nil }
            return PeriodLog(uid: uid, periodLogs: generateDateRange(from: range.start, to: end))
        }
        
        do {
            for log in periodLogs {
                try await PeriodLogService.shared.sendPeriodLogs(periodLog: log)
            }
            print("Logs successfully added for user \(uid).")
        } catch {
            self.errorMessage = "Failed to add logs: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    @MainActor
    func fetchPeriodLogs(uid: String) async {
        isLoading = true
        errorMessage = nil
        
        // Define the API URL
        guard let url = URL(string: "\(APIConfig.baseURL)/period_logs/\(uid)") else {
            self.errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let periodLog = try JSONDecoder().decode(PeriodLog.self, from: data)

            // Convert startDates to Date objects and store in periodDates
            self.periodDates = periodLog.dateObjects()
        } catch {
            self.errorMessage = "Failed to load period logs: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
