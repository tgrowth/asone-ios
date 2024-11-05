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
    
    private var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d" // Format as "Month Day"
        return formatter.string(from: Date())
    }
    
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
        let today = Date()
        if let index = Calendar.current.dateComponents([.weekday], from: today).weekday {
            _selectedDayIndex = State(initialValue: index - 1)  // Subtract 1 because weekday starts from 1 (Sunday)
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
                    VStack(spacing: 20) {
                        HStack {
                            ForEach(0..<7) { index in
                                DayView(
                                    day: getDayOfWeek(for: weekDays[index]),
                                    date: getDate(for: weekDays[index]),
                                    isSelected: index == selectedDayIndex
                                )
                                .onTapGesture {
                                    selectedDayIndex = index
                                }
                            }
                        }.padding()
                        // Grouping symptoms by category
                        let groupedSymptoms = Dictionary(grouping: viewModel.symptoms, by: { $0.type })
                        
                        ForEach(groupedSymptoms.sorted(by: { $0.key < $1.key }), id: \.key) { category, symptoms in
                            SymptomSection(title: category, symptoms: symptoms.map { $0.name }, selectedSymptoms: $selectedSymptoms)
                        }
                    }
                }
                
            }
            
            if selectedSymptoms.count != 0 {
                Button(action: {
                    Task { await applySelectedSymptoms() }
                }) {
                    Text("Apply")
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
            
            Spacer()
        }
        .onAppear {
            Task { await viewModel.loadSymptoms() }
        }
    }
    
    private func applySelectedSymptoms() async {
        for (symptomName, isSelected) in selectedSymptoms where isSelected {
            if let symptom = viewModel.symptoms.first(where: { $0.name == symptomName }) {
                await viewModel.addSymptoms(uid: AuthService.shared.userSession?.uid ?? "unknown uid", symptomId: symptom.id)
            }
        }
    }
    // Helper function to get the day of the week for a specific date
    func getDayOfWeek(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"  // Format as "Mon", "Tue", etc.
        return formatter.string(from: date)
    }
    
    // Helper function to get the date (day number) for a specific day
    func getDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

// SymptomSection View for each category
struct SymptomSection: View {
    var title: String
    var symptoms: [String]
    @Binding var selectedSymptoms: [String: Bool]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 5), spacing: 20) {
                ForEach(symptoms, id: \.self) { symptom in
                    Button(action: {
                        selectedSymptoms[symptom] = !(selectedSymptoms[symptom] ?? false)
                    }) {
                        VStack {
                            Image(systemName: "cloud.fill")
                                .font(.system(size: 24))
                                .foregroundColor(selectedSymptoms[symptom] ?? false ? .black : .gray)
                            Text(symptom)
                                .font(.system(size: 8))
                                .foregroundColor(.black)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 8)
    }
}

#Preview {
    SymptomsView()
}
