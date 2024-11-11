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
                VStack(spacing: 10) {
                    Text("You're in the luteal phase.").fontWeight(.bold)
                    
                    Text("You may feel a bit tired and irritable. This is a great time to communicate openly with your partner about your needs, while showing appreciation for their patience and support.")
                }
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)

                Header(title: "Tips for you")
                
                VStack(spacing: 10) {
                    ForEach(viewModel.tips, id: \.self) { tip in
                        AdviceCard(text: tip)
                    }
                }
                
                Header(title: "Your feedback")
                
                Text("How is your partner responding to your needs during this week?")
                
                HStack(spacing: 10) {
                    ForEach(0..<5) { index in
                        Circle()
                            .fill(index < viewModel.feedbackRating ? Color.teal : Color.gray.opacity(0.2))
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                viewModel.feedbackRating = index + 1
                            }
                    }
                }
            }.padding()
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
