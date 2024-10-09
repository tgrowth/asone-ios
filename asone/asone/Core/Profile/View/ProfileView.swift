//
//  ProfileView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/26/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var showingConfirmation = false
    
    // Language selection
    @State private var selectedLanguage = "English" // Default to English
    
    // List of available languages (you can extend this)
    let availableLanguages = ["English", "Spanish", "Russian"]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Group {
                        // Name
                        HStack {
                            Text(profileViewModel.displayName)
                                .fontWeight(.semibold)
                                .font(.title2)
                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack {
                            Text(profileViewModel.email)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Using For Self or Partner Mode
                        Toggle(isOn: $onboardingViewModel.userData.isUsingForSelf) {
                            Text("Using for Self")
                        }
                        .padding(.horizontal)
                        
                        // Partner Email (conditionally shown if Partner Mode is enabled)
                        if !onboardingViewModel.userData.isUsingForSelf {
                            HStack{
                                TextField("Partner Email", text: $onboardingViewModel.userData.partnerEmail)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                
                                Button {
                                    
                                } label: {
                                    Text("Send")
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Trying to Conceive
                        Toggle(isOn: $onboardingViewModel.userData.isTryingToConceive) {
                            Text("Trying to Conceive")
                        }
                        .padding(.horizontal)
                        

                        // Birthday
                        DatePicker("Birthday", selection: $onboardingViewModel.userData.birthday, displayedComponents: .date)
                            .padding(.horizontal)
                        
                        // Last Period Date
                        DatePicker("Last Period Date", selection: $onboardingViewModel.userData.lastPeriodDate, displayedComponents: .date)
                            .padding(.horizontal)

                        // Cycle Length
                        HStack {
                            Text("Cycle Length")
                            Spacer()
                            TextField("", value: $onboardingViewModel.userData.cycleLength, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal)
                        
                        // Period Length
                        HStack {
                            Text("Period Length")
                            Spacer()
                            TextField("", value: $onboardingViewModel.userData.periodLength, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal)
                        
                        // Language Picker
                        HStack() {
                            Text("Language")
                                .padding(.horizontal)
                            Spacer()
                            Picker("Language", selection: $selectedLanguage) {
                                ForEach(availableLanguages, id: \.self) { language in
                                    Text(language).tag(language)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                        }
                    }
                    
                    // Save Button
                    Button(action: {
                        saveProfileChanges()
                    }) {
                        HStack {
                            Text("Save Changes")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .alert(isPresented: $showingConfirmation) {
                        Alert(title: Text("Profile Updated"), message: Text("Your profile has been successfully updated."), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.top, 20)
            }
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

    // Function to handle saving profile changes
    func saveProfileChanges() {
        // Here, save the user's selected language to UserDefaults or update the app's localization settings
        UserDefaults.standard.set(selectedLanguage, forKey: "AppLanguage")
        onboardingViewModel.completeOnboarding() // Save updates to user data
        showingConfirmation = true
    }
}

#Preview {
    ProfileView()
}
