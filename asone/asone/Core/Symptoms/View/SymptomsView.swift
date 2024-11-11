//
//  SymptomsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/13/24.
//

import SwiftUI

struct SymptomsView: View {
    @StateObject private var viewModel = SymptomsViewModel()
    @State private var selectedSymptoms: [String: Bool] = [:]
    @State private var selectedDayIndex: Int = 0

    private var weekDays: [Date] {
        let calendar = Calendar.current
        let today = Date()
        var weekDays = [Date]()
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for day in 0..<7 {
                if let weekDay = calendar.date(byAdding: .day, value: day, to: weekInterval.start) {
                    weekDays.append(weekDay)
                }
            }
        }
        return weekDays
    }

    init() {
        // Determine today’s index and set as the default selected index
        let today = Date()
        if let index = Calendar.current.dateComponents([.weekday], from: today).weekday {
            _selectedDayIndex = State(initialValue: index - 1)
        }
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading symptoms...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Today, \(Date().toString(format: "MMMM d"))")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }.padding()
                    
                    VStack(spacing: 20) {
                        HStack {
                            ForEach(0..<7) { index in
                                DayView(
                                    day: weekDays[index].toString(format: "E"),
                                    date: weekDays[index].toString(format: "d"),
                                    isSelected: index == selectedDayIndex
                                )
                                .onTapGesture {
                                    selectedDayIndex = index
                                    Task {
                                        await loadSymptomsForSelectedDate()
                                    }
                                }
                            }
                        }
                        .padding()

                        // Group symptoms by category and display each category
                        let groupedSymptoms = Dictionary(grouping: viewModel.markedSymptoms, by: { $0.type })
                        
                        ForEach(groupedSymptoms.sorted(by: { $0.key < $1.key }), id: \.key) { category, symptoms in
                            SymptomSection(
                                title: category,
                                symptoms: symptoms,
                                selectedSymptoms: $selectedSymptoms
                            )
                        }
                    }
                }
            }

            if selectedSymptoms.values.contains(true) {
                Button(action: {
                    Task { await applySelectedSymptoms() }
                }) {
                    Text("Log Symptoms")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .padding(12)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }

            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.loadSymptoms()
                await viewModel.loadSymptomsForDate(uid: AuthService.shared.userSession?.uid ?? "unknown_uid", date: Date().toString(format: "yyyy-MM-dd"))
                selectedDayIndex = Calendar.current.dateComponents([.weekday], from: Date()).weekday! - 1
            }
        }
    }

    func applySelectedSymptoms() async {
        let selectedSymptomsIds = viewModel.markedSymptoms
            .filter { selectedSymptoms[$0.name] == true }
            .map { $0.id }

        guard !selectedSymptomsIds.isEmpty else { return }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: weekDays[selectedDayIndex])

        let symptomLog = SymptomLog(uid: AuthService.shared.userSession?.uid ?? "unknown_uid", date: selectedDate, symptoms: selectedSymptomsIds)

        await viewModel.logSymptoms(symptomLog: symptomLog)
    }

    private func loadSymptomsForSelectedDate() async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: weekDays[selectedDayIndex])

        await viewModel.loadSymptomsForDate(uid: AuthService.shared.userSession?.uid ?? "unknown_uid", date: selectedDate)
    }
}

#Preview {
    SymptomsView()
}
