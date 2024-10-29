//
//  ProfileOptionRow.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/27/24.
//
import SwiftUI

struct ProfileOptionRow: View {
    var icon: String
    var text: LocalizedStringKey
    var iconColor: Color = .black
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
            Text(text)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
    }
}
