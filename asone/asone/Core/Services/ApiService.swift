//
//  ApiService.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/19/24.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    @MainActor
    func signUp(email: String, fullname: String, uid: String, password: String) async throws {
        guard let url = URL(string: "http://api.asone.life/auth/signup") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let userData: [String: Any] = [
            "uid": uid,
            "name": fullname,
            "email": email,
            "password": password
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        print("Response from server: \(jsonResponse)")
    }
    
    @MainActor
    func signIn(withToken token: String) async throws {
        guard let url = URL(string: "http://api.asone.life/auth/signin") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if httpResponse.statusCode == 200 {
            print("Token successfully sent to backend")
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            print("Response from server: \(jsonResponse)")
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func forgotPassword(email: String) async throws {
        guard let url = URL(string: "http://api.asone.life/forgot-password") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        print("Forgot password response: \(jsonResponse)")
    }

    @MainActor
    func resetPassword(newPassword: String, token: String) async throws {
        guard let url = URL(string: "http://api.asone.life/reset-password") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "token": token,
            "password": newPassword
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        print("Reset password response: \(jsonResponse)")
    }
    
    @MainActor
    func verifyCode(verificationCode: String) async throws {
        guard let url = URL(string: "http://api.asone.life/verify") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["code": verificationCode]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        print("Response from server: \(jsonResponse)")
    }
}
