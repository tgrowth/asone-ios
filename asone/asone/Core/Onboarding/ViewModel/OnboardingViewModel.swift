import SwiftUI
import FirebaseAuth

// Define the steps in the onboarding process
enum OnboardingStep: Int, CaseIterable {
    case step1, step2, step3, step4, step5, step6, step7
}

// A model to store the user data collected during the onboarding process
struct OnboardingUserData {
    var isUsingForSelf: Bool = true
    var code: String = ""
    var birthday: Date = Date()
    var periodLength: Int = 6
    var cycleLength: Int = 28
    var lastPeriodDate: Date = Date()
    var isTryingToConceive: Bool = false
    var isPartnerMode: Bool = false
    var partnerEmail: String = ""
    var inviteCode: String = ""
    var isComplete: Bool = false
}

class OnboardingViewModel: ObservableObject {
    // Track the current step in the onboarding process
    @Published var currentStep: OnboardingStep = .step1
    
    // Store the user data
    @Published var userData = OnboardingUserData()
    
    // Navigate to the next step
    func goToNextStep() {
        if let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = nextStep
        }
    }
    
    // Navigate to the previous step
    func goToPreviousStep() {
        if let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1) {
            currentStep = previousStep
        }
    }
    
    // Finalize the onboarding process
    func completeOnboarding() {
        // Logic to handle when the user completes onboarding (e.g., saving user data)
        
        guard let user = Auth.auth().currentUser else {
            print("No Firebase user found")
            return
        }
        
        user.getIDToken { token, error in
            if let error = error {
                print("Error fetching ID token: \(error)")
                return
            }
            
            guard let token = token else {
                print("No token found")
                return
            }
            
            self.sendToken(token: token)
        }

        self.userData.isComplete = true
        self.submitUserData()
    }
    
    private func sendToken(token: String) {
        guard let url = URL(string: "http://api.asone.life/signin") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the headers
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending token to backend: \(error)")
                return
            }
            
            // Handle response from the backend
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Token successfully sent to backend")
                } else {
                    print("Failed to send token. Status code: \(httpResponse.statusCode)")
                }
            }
        }
        
        task.resume()
    }

    func generateInviteCode(length: Int = 6) {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let inviteCode = String((0..<length).map { _ in characters.randomElement()! })
        userData.inviteCode = inviteCode
    }
    
    func submitUserData() {
        // Create a DateFormatter to ensure correct formatting for "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Format the dates to strings
        let formattedBirthday = dateFormatter.string(from: userData.birthday)
        let formattedLastPeriodDate = dateFormatter.string(from: userData.lastPeriodDate)
        
        // Convert the user data to a dictionary with the formatted date strings
        let userDataDictionary: [String: Any] = [
            "isUsingForSelf": userData.isUsingForSelf,
            "code": userData.code,
            "birthday": formattedBirthday,  // Use the formatted birthday
            "periodLength": userData.periodLength,
            "cycleLength": userData.cycleLength,
            "lastPeriodDate": formattedLastPeriodDate,  // Use the formatted lastPeriodDate
            "isTryingToConceive": userData.isTryingToConceive,
            "isPartnerMode": userData.isPartnerMode,
            "partnerEmail": userData.partnerEmail,
            "inviteCode": userData.inviteCode,
            "isComplete": userData.isComplete
        ]
        
        // Convert dictionary to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userDataDictionary) else {
            print("Error serializing user data to JSON")
            return
        }

        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")

        // Get the current Firebase user and their UID
        guard let user = Auth.auth().currentUser else {
            print("No Firebase user found")
            return
        }
        
        let userId = user.uid;

        sendUserData(jsonData: jsonData, userId: 4) // userId
    }

    private func sendUserData(jsonData: Data, userId: Int) { //change to string uid
        guard let url = URL(string: "http://api.asone.life/userInfo/\(userId)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Send the JSON data
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending user data to backend: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("User data successfully sent to backend.")
                } else {
                    print("Failed to send user data. Status code: \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
}
