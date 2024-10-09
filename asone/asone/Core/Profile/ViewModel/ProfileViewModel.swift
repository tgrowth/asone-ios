import Foundation
import Combine
import SwiftUI
import FirebaseAuth

struct UserProfile: Codable {
    let id: Int
    let isUsingForSelf: Bool
    let code: String
    let birthday: String
    let periodLength: Int
    let cycleLength: Int
    let lastPeriodDate: String
    let isTryingToConceive: Bool
    let isPartnerMode: Bool
    let partnerEmail: String
    let inviteCode: String
    let isComplete: Bool
}

class ProfileViewModel: ObservableObject {
    @Published var uid: String = ""
    @Published var email: String = ""
    @Published var displayName: String = ""
    
    @Published var currentUser: UserProfile? // Store the fetched user profile here
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.uid = user.uid
            self.email = user.email ?? "No Email"
            self.displayName = user.displayName ?? "No Name"
            
            // Fetch user data from the backend once the user is authenticated
            
            getUserData(userId: 4) // user.uid
        } else {
            print("No user is logged in")
        }
    }
    
    private func getUserData(userId: Int) {
        guard let url = URL(string: "http://api.asone.life/userInfo/\(userId)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200, let data = data {
                    do {
                        // Decode the data into a dictionary first
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let userInfo = jsonResponse["userInfo"] as? [String: Any] {
                            // Convert userInfo into JSON Data again to decode into UserProfile
                            let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: [])
                            
                            // Decode the userInfo data into the UserProfile model
                            let decoder = JSONDecoder()
                            let userProfile = try decoder.decode(UserProfile.self, from: jsonData)
                            
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                self.currentUser = userProfile
                            }
                        } else {
                            print("Invalid JSON format")
                        }
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                } else {
                    print("Failed to fetch user data. Status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }

}
