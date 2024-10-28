//
//  AuthService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import FirebaseAuth

class AuthService: ObservableObject {
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        addAuthStateListener()
    }
    
    private func addAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
        }
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
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
    func thirdPartyLogin(credential: AuthCredential) async throws {
       do {
           let result = try await Auth.auth().signIn(with: credential)
           self.userSession = result.user
           try await ApiService.shared.signIn(withToken: result.user.getIDToken())
       } catch {
           print("ERROR: \(error.localizedDescription)")
       }
    }
    
    @MainActor
    func register(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            UserDefaults.standard.set(false, forKey: "onboardingComplete")
            
            try await ApiService.shared.signUp(email: email, fullname: fullname, uid: result.user.uid, password: password)
        } catch {
            print("ERROR: \(error.localizedDescription)")
            throw error
        }
    }

    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
    
    func deleteFirebaseUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "DeleteUserError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found."])
        }

        do {
            try await user.delete()
            self.signOut()
            print("Firebase user deleted successfully.")
        } catch {
            print("Error deleting Firebase user: \(error.localizedDescription)")
            throw error
        }
    }
    
    

}
