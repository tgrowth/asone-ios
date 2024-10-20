//
//  AuthService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import FirebaseAuth

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await ApiService.shared.signIn(withToken: result.user.getIDToken())
        } catch {
            print("ERROR: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func register(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await ApiService.shared.signUp(email: email, fullname: fullname, uid: result.user.uid)
        } catch {
            print("ERROR: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func forgotPassword(withEmail email: String) async throws {
        do {
            try await ApiService.shared.forgotPassword(withEmail: email)
            print("Password reset request sent")
        } catch {
            print("Failed to request password reset: \(error.localizedDescription)")
            throw error
        }
    }

    @MainActor
    func resetPassword(newPassword: String, token: String) async throws {
        do {
            try await ApiService.shared.resetPassword(newPassword: newPassword, resetToken: token)
            print("Password successfully reset")
        } catch {
            print("Failed to reset password: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
}
