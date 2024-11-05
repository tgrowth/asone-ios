//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    @State private var selectedDays: [Int] = []
    
    let daysRange = Array(1...30)

    var body: some View {
        VStack {
            Text("Select your cycle days")
                .font(.headline)
            
            // Grid of buttons to select multiple days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(daysRange, id: \.self) { day in
                    DayButton(day: day, isSelected: selectedDays.contains(day)) {
                        toggleDaySelection(day: day)
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
        }
        .padding()
    }

    func toggleDaySelection(day: Int) {
        if let index = selectedDays.firstIndex(of: day) {
            selectedDays.remove(at: index)
        } else {
            selectedDays.append(day)
        }
    }
}

struct DayButton: View {
    var day: Int
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(day)")
                .frame(width: 40, height: 40)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(10)
                .font(.headline)
        }
    }
}

#Preview {
    OnboardingStepView(viewModel: OnboardingViewModel())
}
