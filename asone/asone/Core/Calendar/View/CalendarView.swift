//
//  CalendarView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/24/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel = CalendarViewModel()

    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollView(showsIndicators: false){
            VStack {
                // Month Navigation Header
                HStack {
                    Button(action: {
                        viewModel.previousMonth()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                    }
                    Spacer()
                    Text("\(monthYearString(for: viewModel.displayedMonth))")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        viewModel.nextMonth()
                    }) {
                        Image(systemName: "chevron.right")
                            .padding()
                    }
                }
                .padding()

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.daysForMonth(), id: \.self) { date in
                        CalendarDayView(date: date, isSelected: viewModel.isSelected(date), isToday: viewModel.isToday(date))
                            .onTapGesture {
                                viewModel.selectedDate = date
                            }
                    }
                }
                .padding(.horizontal)
                

                if viewModel.selectedDate != nil {
                    Button(action: {
                        Task { await viewModel.addPeriodLogs(uid: AuthService.shared.userSession?.uid ?? "unknown uid") }
                    }) {
                        Text("Log Period")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 100)
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
            }
        }.navigationTitle("Calendar")
    }

    // Helper to format the month and year
    func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool

    var body: some View {
        Text(dayString(for: date))
            .fontWeight(isSelected ? .bold : .regular)
            .frame(width: 40, height: 40)
            .background(isSelected ? Color.black : (isToday ? Color.gray.opacity(0.3) : Color.clear))
            .cornerRadius(10)
            .foregroundColor(isSelected ? .white : .black)
    }

    // Get the day as a string
    func dayString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
