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
    
    func fetchUserData(uid: String, completion: @escaping (UserData?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/userInfo/\(uid)") else {
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
                print(jsonResponse)
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
    
    func fetchIsComplete(uid: String, completion: @escaping (Bool?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/user/\(uid)/isComplete") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching isComplete data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("Failed to fetch isComplete data")
                completion(nil)
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let isComplete = jsonResponse?["isComplete"] as? Bool {
                    completion(isComplete)
                } else {
                    print("Invalid JSON format or missing isComplete field")
                    completion(nil)
                }
            } catch {
                print("Error decoding isComplete data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func reset(){
        self.currentUser = nil
    }
}


