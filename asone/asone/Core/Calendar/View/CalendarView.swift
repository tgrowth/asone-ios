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
        ScrollView(showsIndicators: false) {
            VStack {
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

                // Calendar Grid
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.daysForMonth(), id: \.self) { date in
                        CalendarDayView(
                            date: date,
                            isSelected: viewModel.isSelected(date),
                            isToday: viewModel.isToday(date),
                            isFuture: viewModel.isFuture(date),
                            isPeriodDate: viewModel.periodDates.contains { viewModel.calendar.isDate($0, inSameDayAs: date) }
                        )
                        .onTapGesture {
                            if !viewModel.isFuture(date) {
                                viewModel.selectDate(date)
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if viewModel.selectedRanges.count > 0 {
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
            .onAppear {
                Task {
                    await viewModel.fetchPeriodLogs(uid: AuthService.shared.userSession?.uid ?? "unknown uid")
                }
            }
        }
    }

    func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
