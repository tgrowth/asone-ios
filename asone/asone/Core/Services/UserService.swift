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
    
    func sendUserData(userDataDictionary: [String: Any]) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)\(APIConfig.userInfoEndpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userDataDictionary) else {
            throw NSError(domain: "SerializationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize user data."])
        }
        
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: "Failed to send user data to backend."])
        }
        
        print("User data successfully sent to backend: \(String(data: data, encoding: .utf8) ?? "No response data")")
    }

    
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

            guard let httpResponse = response as? HTTPURLResponse else {
                print("No valid HTTP response")
                completion(nil)
                return
            }
            
            if httpResponse.statusCode == 404 {
                // No user data found, treat as no onboarding data
                completion(nil)
                return
            } else if httpResponse.statusCode == 200, let data = data {
                // Successfully fetched user data, parse it
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
            } else {
                print("Failed to fetch user data, status code: \(httpResponse.statusCode)")
                completion(nil)
            }
        }.resume()
    }

//    func fetchIsComplete(uid: String, completion: @escaping (Bool?) -> Void) {
//        guard let url = URL(string: "http://localhost:3000/user/\(uid)/isComplete") else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error fetching isComplete data: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("No valid HTTP response")
//                completion(nil)
//                return
//            }
//            
//            if httpResponse.statusCode == 200, let data = data {
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let isComplete = jsonResponse?["isComplete"] as? Bool {
//                        completion(isComplete)
//                    } else {
//                        print("Invalid JSON format or missing isComplete field")
//                        completion(false)
//                    }
//                } catch {
//                    print("Error decoding isComplete data: \(error.localizedDescription)")
//                    completion(false)
//                }
//            } else {
//                print("Failed to fetch isComplete data, status code: \(httpResponse.statusCode)")
//                completion(false)
//            }
//        }.resume()
//    }

    func reset(){
        self.currentUser = nil
    }
}


