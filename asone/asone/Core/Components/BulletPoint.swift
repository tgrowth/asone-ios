//
//  BulletPoint.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/20/24.
//

import SwiftUI

struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 12, height: 12)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}
