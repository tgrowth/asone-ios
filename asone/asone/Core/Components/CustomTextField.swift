//
//  CustomTextField.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: LocalizedStringKey
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CustomTextField(placeholder: "Email", text: .constant(""))
}

