//
//  SymptomsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/13/24.
//

import SwiftUI

struct SymptomsView: View {
    @State private var selectedDate = 2 // Example: Selected date is October 2
    @State private var selectedSymptoms: [String: Bool] = [:] // To track selected symptoms

    var body: some View {
        VStack {
            // Date Selection Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(30..<37, id: \.self) { day in
                        Button(action: {
                            selectedDate = day
                        }) {
                            Text("\(day)")
                                .font(.headline)
                                .padding(10)
                                .background(selectedDate == day ? Color.black : Color.gray.opacity(0.2))
                                .foregroundColor(selectedDate == day ? .white : .black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }

            // Symptom Categories
            ScrollView {
                SymptomSection(title: "Mood", symptoms: ["happy", "calm", "anxios", "irritable", "sad"], selectedSymptoms: $selectedSymptoms)

                SymptomSection(title: "Stress & Emotions", symptoms: ["relaxed", "overwhelmed", "sensitive", "mood swings", "confident"], selectedSymptoms: $selectedSymptoms)

                SymptomSection(title: "Physical Symptoms", symptoms: ["fatigue", "cramps", "headache", "bloating", "breast tenderness"], selectedSymptoms: $selectedSymptoms)

                SymptomSection(title: "Activities", symptoms: ["exercise", "work", "social", "travel", "outdoor activities"], selectedSymptoms: $selectedSymptoms)
            }.frame(height: 400)

            // Apply Button
            Button(action: {
                // Action for applying selected symptoms
            }) {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.padding(.horizontal)
        }
        .navigationTitle("Symptoms")
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

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 5), spacing: 20) {
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
