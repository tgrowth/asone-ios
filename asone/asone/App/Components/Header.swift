//
//  Header.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import SwiftUI

struct Header: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .padding(10)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
