//
//  SignUpViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email = "";
    @Published var password = "";
    @Published var fullname = "";
    
    @MainActor
    func register() async throws {
        try await AuthService.shared.register(withEmail: email, password: password, fullname: fullname)
    }
}
