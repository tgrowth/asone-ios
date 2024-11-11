//
//  OnboardingStep15View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep15View: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State private var selectedSymptoms: [Int] = []

    var body: some View {
        VStack {
            Header(title: "Why are you feeling like this today?")
            
            if viewModel.isLoading {
                ProgressView("Loading symptoms...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(viewModel.symptoms, id: \.self) { symptom in
                        Button(action: {
                            toggleSymptom(symptom.id)
                        }) {
                            Text(symptom.name)
                                .padding(8)
                                .foregroundColor(isSymptomSelected(symptom.id) ? Color.white : Color.black)
                                .background(isSymptomSelected(symptom.id) ? Color.black : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding()
            }

            Spacer()
            
            // Navigation buttons
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.userData.symptom_logs = selectedSymptoms 
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.loadSymptoms()
            }
        }
    }

    // Function to toggle selection of symptom IDs
    private func toggleSymptom(_ symptomId: Int) {
        if let index = selectedSymptoms.firstIndex(of: symptomId) {
            selectedSymptoms.remove(at: index)  // Remove if already selected
        } else {
            selectedSymptoms.append(symptomId)  // Add if not selected
        }
    }

    // Function to check if a symptom ID is selected
    private func isSymptomSelected(_ symptomId: Int) -> Bool {
        selectedSymptoms.contains(symptomId)
    }
}

#Preview {
    OnboardingStep15View(viewModel: OnboardingViewModel())
}
