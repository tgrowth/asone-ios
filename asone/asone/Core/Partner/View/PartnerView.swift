//
//  PartnerView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/16/24.
//

import SwiftUI

struct PartnerView: View {
    @ObservedObject var viewModel: PartnerViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("You're in the luteal phase.")
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                
                Text("You may feel a bit tired and irritable. This is a great time to communicate openly with your partner about your needs, while showing appreciation for their patience and support.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Emotions
                Text("Tell your partner about your emotions for today")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    ForEach(viewModel.emotions, id: \.self) { emotion in
                        //emotions
                    }
                }
                
                // Tips Section
                Text("Tips for you")
                    .font(.headline)
                
                VStack(spacing: 10) {
                    ForEach(viewModel.tips, id: \.self) { tip in
                        Text(tip)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                // Feedback Section
                Text("Your feedback")
                    .font(.headline)
                
                Text("How is your partner responding to your needs during this week?")
                    .font(.subheadline)
                    .padding(.top, 5)
                
                HStack(spacing: 10) {
                    ForEach(0..<5) { index in
                        Circle()
                            .fill(index < viewModel.feedbackRating ? Color.blue : Color.gray.opacity(0.2))
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                viewModel.feedbackRating = index + 1
                            }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("\(viewModel.partner?.username ?? "Error") is connected")
        .onAppear {
            viewModel.fetchPartnerProfile(uid: AuthService.shared.userSession?.uid ?? "unknown uid")
        }
    }
}

#Preview {
    PartnerView(viewModel: PartnerViewModel())
}
