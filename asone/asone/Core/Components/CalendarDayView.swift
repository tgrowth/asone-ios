//
//  CalendarDayView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/30/24.
//

import SwiftUI

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let isFuture: Bool
    let isPeriodDate: Bool

    var body: some View {
        Text(dayString(for: date))
            .fontWeight(isSelected ? .bold : .regular)
            .frame(width: 40, height: 40)
            .background(isSelected ? Color.black : (isPeriodDate ? Color.teal : (isToday ? Color.gray.opacity(0.3) : Color.clear)))
            .cornerRadius(10)
            .foregroundColor(isFuture ? .gray : (isSelected || isPeriodDate ? .white : .black))
    }

    func dayString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
