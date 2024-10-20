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
import CryptoKit
import AuthenticationServices


class LoginViewModel: ObservableObject {
    @Published var email = "";
    @Published var password = "";
    @Published var nonce: String?
    
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
        
        try await AuthService.shared.thirdPartyLogin(credential: credential)
    }
    
    func appleLogin(_ authorization: ASAuthorization) async throws {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
          guard let nonce else {
            print("Invalid state: A login callback was received, but no login request was sent.")
            return
          }
          guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
          }
          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
          }
          // Initialize a Firebase credential, including the user's full name.
          let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                            rawNonce: nonce,
                                                            fullName: appleIDCredential.fullName)
          // Sign in with Firebase.
          try await AuthService.shared.thirdPartyLogin(credential: credential)
        }
    }
    
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}
