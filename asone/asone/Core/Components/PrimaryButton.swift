//
//  PrimaryButton.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct PrimaryButton: View {
    var title: LocalizedStringKey
    var action: () -> Void
    var isDisabled: Bool = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(isDisabled ? Color.gray : Color.black)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
        .disabled(isDisabled)
    }
}

#Preview {
    PrimaryButton(title: "Login", action: {}, isDisabled: false)
}
