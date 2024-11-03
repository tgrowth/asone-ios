//
//  TipView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 11/2/24.
//

import SwiftUI

struct TipView: View {
    var tipNumber: Int
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tip #\(tipNumber)")
                .font(.footnote)
                .bold()
            Text(text)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}
