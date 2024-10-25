//
//  DayView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import SwiftUI

struct DayView: View {
    var day: String
    var date: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(day)
                .font(.body)
                .foregroundColor(isSelected ? .black : .gray)
            
            Text(date)
                .font(.caption)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .black : .gray)
                .padding(12)
                .background(isSelected ? Color.black.opacity(0.1) : Color.clear)
                .cornerRadius(8)
        }
    }
}
