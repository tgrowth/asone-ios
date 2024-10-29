//
//  StatisticsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel = StatisticsViewModel()
    
    // State to track which view to display (History by default)
    @State private var showingHistory = true
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                // Cycle and Period Length Statistics
                VStack(spacing: 20) {
                    Text("Averaging your last 6 cycles")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        VStack {
                            Text("\(viewModel.cycleLength)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("cycle length")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            Text("\(viewModel.periodLength)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("period length")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
                
                // History and Predictions Toggle
                HStack {
                    Button(action: {
                        showingHistory = true // Show History
                    }) {
                        Text("History")
                            .padding()
                            .background(showingHistory ? Color.black : Color.white)
                            .foregroundColor(showingHistory ? .white : .black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        showingHistory = false // Show Predictions
                    }) {
                        Text("Predictions")
                            .padding()
                            .background(!showingHistory ? Color.black : Color.white)
                            .foregroundColor(!showingHistory ? .white : .black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
                .padding(.vertical)
                
                // Display either History or Predictions based on the toggle state
                if showingHistory {
                    // Cycle History List
                    VStack(alignment: .leading) {
                        HStack {
                            Text("First Day")
                            Spacer()
                            Text("Length")
                            Spacer()
                            Text("Cycle")
                        }
                        .padding(.horizontal)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                        ForEach(viewModel.history) { item in
                            HStack {
                                Text(item.startDate)
                                Spacer()
                                Text("\(item.length)")
                                Spacer()
                                HStack {
                                    Text("\(item.cycle)")
                                    if item.isExpected {
                                        Text("expected")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                    }
                } else {
                    // Predictions List
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Prediction Date")
                            Spacer()
                            Text("Predicted Cycle")
                        }
                        .padding(.horizontal)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                        ForEach(viewModel.predictions) { prediction in
                            HStack {
                                Text(prediction.date)
                                Spacer()
                                Text("\(prediction.predictedCycle)")
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("Statistics")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Export action
                }) {
                    Image(systemName: "square.and.arrow.up").foregroundColor(.black)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCycleHistory(uid: AuthService.shared.userSession?.uid ?? "unknown_uid")
            }
        }
    }
}

#Preview {
    NavigationView {
        StatisticsView()
    }
}
