//
//  AdviceCard.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//
import SwiftUI

struct AdviceCard: View {
    var text: LocalizedStringKey
    
    var body: some View {
        VStack {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}
