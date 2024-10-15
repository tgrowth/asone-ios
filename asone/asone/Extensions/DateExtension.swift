//
//  DateExtension.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/15/24.
//

import Foundation

extension Date {
    
    static func fromISO8601String(_ dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString)
    }
    
    // Convert Date to String with a specific format
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // Convert Date to a relative time string (e.g., "2 hours ago")
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    // Convert String to Date with a specific format
    static func fromString(_ dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    // Get the start of the day for a Date
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    // Get the end of the day for a Date
    func endOfDay() -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: self.startOfDay())
    }
    
    // Convert Date to a custom timezone
    func toTimezone(_ timezone: TimeZone) -> Date? {
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return addingTimeInterval(seconds)
    }
}
