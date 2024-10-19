//
//  QuizResultView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/10/24.
//

import SwiftUI

struct QuizResultView: View {
    @StateObject var viewModel = QuizViewModel()
    var quizResult: [String: Double]
    
    @State private var navigate = false
    
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

            // List of results displaying the calculated percentages
            ForEach(quizResult.sorted(by: { $0.value > $1.value }), id: \.key) { category, percentage in
                HStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 10)
                    
                    Text(category)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text(String(format: "%.1f%%", percentage))
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            
            Spacer()
            
            // Next Button
            NavigationLink(destination: CompareView(), isActive: $navigate) {
                Button(action: {
                    navigate = true
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
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getQuizResults(uid: UserService.shared.getCurrentUserUid() ?? "")
        }
    }
}
