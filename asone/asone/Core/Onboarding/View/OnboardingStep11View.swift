//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep11View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var lastPeriodEndDate: Date = Date()
    @State private var periodLength: String = "5"  // Default period length is 5 days
    @State private var showingInvalidLengthAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Tell us about your last period")
                .font(.headline)
            
            // Last period date picker
            VStack(alignment: .leading, spacing: 10) {
                Text("Last Period End Date")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                DatePicker("Select the last day of your period", selection: $lastPeriodEndDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            }
            
            // Period length input
            VStack(alignment: .leading, spacing: 10) {
                Text("How long did your period last? (in days)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField("Period Length", text: $periodLength)
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            Spacer()
            
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    if let periodLengthInt = Int(periodLength), periodLengthInt > 0 {
                        // Calculate the start date
                        let startDate = Calendar.current.date(byAdding: .day, value: -periodLengthInt, to: lastPeriodEndDate) ?? lastPeriodEndDate
                        
                        // Save dates to the view model
                        viewModel.userData.lastPeriodEndDate = lastPeriodEndDate
                        viewModel.userData.lastPeriodStartDate = startDate
                        
                        viewModel.goToNextStep()
                    } else {
                        showingInvalidLengthAlert = true
                    }
                }
            )
            .alert(isPresented: $showingInvalidLengthAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Please enter a valid period length greater than 0."), dismissButton: .default(Text("OK")))
            }
        
        }
        .padding()
    }
}

#Preview {
    OnboardingStep11View(viewModel: OnboardingViewModel())
}
