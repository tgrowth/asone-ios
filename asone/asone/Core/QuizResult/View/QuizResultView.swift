//
//  QuizResultView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/10/24.
//

import SwiftUI

struct QuizResultView: View {
    // Example data for quiz result categories and their percentages
    let results: [(category: String, percentage: Int)] = [
        ("Words of Affirmation", 40),
        ("Acts of Service", 25),
        ("Receiving Gifts", 15),
        ("Quality Time", 10),
        ("Physical Touch", 5)
    ]
    
    // State to control the navigation
    @State private var navigateToHome = false
    
    var body: some View {
        VStack {
            // Top Text
            Text("Your love language is...")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            // Placeholder for the user's profile or result image
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.vertical, 30)
            
            // List of results
            ForEach(results, id: \.category) { result in
                HStack {
                    // Radio button icon
                    Circle()
                        .fill(Color.black)
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 10)
                    
                    // Category and percentage
                    Text(result.category)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("\(result.percentage)%")
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color(UIColor.systemGray5)) // Light gray background
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            
            Spacer()
            
            // Next Button
            NavigationLink(destination: MainView(), isActive: $navigateToHome) {
                Button(action: {
                    navigateToHome = true // Trigger navigation to HomeView
                }) {
                    Text("Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true) // Optional: Hide the back button
    }
}

#Preview {
    QuizResultView()
}
