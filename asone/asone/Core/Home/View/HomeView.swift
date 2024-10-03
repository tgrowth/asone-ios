//
//  HomeView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/2/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Cycle Overview
                    VStack(alignment: .leading) {
                        Text("Your Cycle")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text("Day 14 of 28-day cycle")
                            .font(.subheadline)
                        ProgressView(value: 14, total: 28)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Health Metrics
                    VStack(alignment: .leading) {
                        Text("Health Overview")
                            .font(.headline)
                            .padding(.bottom, 2)
                        HStack {
                            VStack {
                                Text("Steps")
                                Text("6,500")
                                    .font(.title)
                            }
                            Spacer()
                            VStack {
                                Text("Sleep")
                                Text("7 hrs")
                                    .font(.title)
                            }
                            Spacer()
                            VStack {
                                Text("Heart Rate")
                                Text("72 BPM")
                                    .font(.title)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Daily Tips
                    VStack(alignment: .leading) {
                        Text("Daily Tips")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text("Did you know that staying hydrated can help alleviate period cramps?")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Calendar Preview
                    VStack(alignment: .leading) {
                        Text("Upcoming Events")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text("Next period starts on October 10th")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // Quick Symptom Logging
                    VStack(alignment: .leading) {
                        Text("Log Today's Symptoms")
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        // Mood and Symptoms Logging
                        HStack {
                            Button(action: {
                                // Log mood
                            }) {
                                Text("Mood")
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            Spacer()
                            Button(action: {
                                // Log symptoms
                            }) {
                                Text("Symptoms")
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
