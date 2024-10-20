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
        guard let token = try? await Auth.auth().currentUser?.getIDToken() else {
            print("Failed to retrieve Firebase token")
            return
        }

        guard let url = URL(string: "http://api.asone.life/me") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Failed to fetch user data, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            return
        }

        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            self.currentUser = user
            print("User data successfully fetched from backend")
        } catch {
            print("Error decoding user data: \(error.localizedDescription)")
        }
    }

    
    func fetchUserData(uid: String, completion: @escaping (UserData?) -> Void) {
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
                    let userProfile = try decoder.decode(UserData.self, from: jsonData)
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


