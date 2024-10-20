//
//  OnboardingStep15View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep15View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedSymptoms: [String] = []
    
    let symptoms = ["Symptom 1", "Symptom 2", "Symptom 3", "Symptom 4", "Symptom 5", "Symptom 6", "Symptom 7", "Symptom 8"]
    
    var body: some View {
        VStack {
            // Custom header component
            Header(title: "Why are you feeling like this today?")
            
            // Grid of symptom buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(symptoms, id: \.self) { symptom in
                    Button(action: {
                        toggleSymptom(symptom)
                    }) {
                        Text(symptom)
                            .padding(8)
                            .foregroundColor(isSymptomSelected(symptom) ? Color.white : Color.black)
                            .background(isSymptomSelected(symptom) ? Color.black : Color.clear)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // Navigation buttons
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.userData.symptoms = selectedSymptoms
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
    }
    
    // Function to toggle the symptom in the selection array
    private func toggleSymptom(_ symptom: String) {
        if let index = selectedSymptoms.firstIndex(of: symptom) {
            selectedSymptoms.remove(at: index)
        } else {
            selectedSymptoms.append(symptom)
        }
    }
    
    // Helper function to check if the symptom is selected
    private func isSymptomSelected(_ symptom: String) -> Bool {
        selectedSymptoms.contains(symptom)
    }
}

#Preview {
    OnboardingStep15View(viewModel: OnboardingViewModel())
}
