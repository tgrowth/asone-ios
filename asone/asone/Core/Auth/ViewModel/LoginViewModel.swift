//
//  LoginViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth


class LoginViewModel: ObservableObject {
    @Published var email = "";
    @Published var password = "";
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
    func googleLogin() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController)

        guard let idToken: String = signInResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        let accessToken: String = signInResult.user.accessToken.tokenString

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        try await AuthService.shared.googleLogin(credential: credential)
    }
}
