//
//  PrimaryButton.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct PrimaryButton<Destination: View>: View {
    var title: String
    var destination: Destination?
    var isDisabled: Bool = false
    
    var body: some View {
        if let destination = destination {
            NavigationLink(destination: destination) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(isDisabled ? Color.gray : Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .disabled(isDisabled)
        } else {
            Button(action: {}) {
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
}

#Preview {
    NavigationStack {
        PrimaryButton(title: "Sign Up", destination: Text("Onboarding Screen"))
    }
}
