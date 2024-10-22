//
//  SettingsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Cycle Settings
                    Section(header: Text("Cycle settings")
                        .font(.title2)
                        .fontWeight(.bold)) {
                        
                        // Cycle Length Picker
                        VStack(alignment: .leading) {
                            Text("Cycle length")
                                .font(.headline)
                            Picker("Cycle Length", selection: $viewModel.cycleLength) {
                                ForEach(1...30, id: \.self) { value in
                                    Text("\(value) days").tag(value)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                        
                        // Period Length Picker
                        HStack {
                            Text("Period length")
                                .font(.headline)
                            Spacer()
                            Picker("Period Length", selection: $viewModel.periodLength) {
                                ForEach(1...10, id: \.self) { value in
                                    Text("\(value) days").tag(value)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                        
                        // Pregnancy Probability Toggle
                        HStack {
                            Text("Pregnancy probability")
                                .font(.headline)
                            Spacer()
                            Toggle("", isOn: $viewModel.pregnancyProbability)
                                .toggleStyle(SwitchToggleStyle(tint: .black))
                        }
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    }
                    
                    // Notifications Section
                    Section(header: Text("Notifications")
                        .font(.title2)
                        .fontWeight(.bold)) {
                        
                        ForEach(viewModel.notifications.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(key)
                                    .font(.headline)
                                Spacer()
                                Toggle("", isOn: Binding(
                                    get: { viewModel.notifications[key] ?? false },
                                    set: { viewModel.notifications[key] = $0 }
                                ))
                                .toggleStyle(SwitchToggleStyle(tint: .black))
                            }
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
