//
//  AuthService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import FirebaseAuth
import FirebaseFirestore


class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func thirdPartyLogin(credential: AuthCredential) async throws {
        do {
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func register(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, fullname: fullname, id: result.user.uid)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    @MainActor func resetPassword(withEmail email: String) async throws {
        
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
    
    @MainActor
    private func uploadUserData(withEmail email: String, fullname: String, id: String) async throws {
        let user = User(id: id, fullname: fullname, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}
