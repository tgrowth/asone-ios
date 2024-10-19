//
//  OnboardingStep15View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct OnboardingStep15View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedSymptoms: [Bool] = Array(repeating: false, count: 8)
    
    let symptoms = ["Symptom 1", "Symptom 2", "Symptom 3", "Symptom 4", "Symptom 5", "Symptom 6", "Symptom 7", "Symptom 8"]
    
    var body: some View {
        VStack {
            Text("Why are you feeling like this today?")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            // Grid of symptom buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<symptoms.count, id: \.self) { index in
                    Button(action: {
                        selectedSymptoms[index].toggle()
                    }) {
                        Text(symptoms[index])
                            .padding(8)
                            .background(selectedSymptoms[index] ? Color.gray : Color.clear)
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
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    viewModel.goToNextStep()
                }
            )
        }.padding()
    }
}

#Preview {
    OnboardingStep15View(viewModel: OnboardingViewModel())
}

