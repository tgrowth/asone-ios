//
//  UserService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation
import FirebaseAuth

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    private init() {}
    
    // MARK: - Send User Data
    func sendUserData(userDataDictionary: [String: Any]) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)/userInfo/") else {
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
    
    // MARK: - Fetch User Data
    func fetchUserData(uid: String, completion: @escaping (UserData?) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/userInfo/\(uid)") else {
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
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
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
    
    // MARK: - Update User Data
    func updateUserData(uid: String, userData: [String: Any]) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)/userInfo/\(uid)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: "Failed to update user data"])
        }
    }
    
    // MARK: - Add Partner
    func addPartner(uid: String, code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/userInfo/\(uid)/partner") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["code": code]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize request body.")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error adding partner: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Partner added successfully")
                completion(true)
            } else {
                print("Failed to add partner")
                completion(false)
            }
        }.resume()
    }
    
    func fetchPartnerData(uid: String, completion: @escaping (UserData?) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/userInfo/\(uid)/partner") else {
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
                    
                    if let userInfo = jsonResponse?["partner"] as? [String: Any] {
                        let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: [])
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
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

    // MARK: - Reset
    func reset() {
        self.currentUser = nil
    }
}
