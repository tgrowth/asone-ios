//
//  UserService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import FirebaseAuth
import FirebaseFirestore


class UserService{
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    private init() {}

    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    func getCurrentUserUid() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }
    
    func fetchUserData(uid: String, completion: @escaping (UserProfile?) -> Void) {
        guard let url = URL(string: "http://api.asone.life/userInfo/\(uid)") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("Failed to fetch user data")
                completion(nil)
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let userInfo = jsonResponse?["userInfo"] as? [String: Any] {
                    let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: [])
                    let decoder = JSONDecoder()
                    let userProfile = try decoder.decode(UserProfile.self, from: jsonData)
                    completion(userProfile)
                } else {
                    print("Invalid JSON format")
                    completion(nil)
                }
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    
    func reset(){
        self.currentUser = nil
    }
}


