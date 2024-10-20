import SwiftUI
import FirebaseAuth

enum OnboardingStep: Int, CaseIterable {
    case start, step1, step2, step3, step4, step5, step6, step7, step8, step9, step10, step11, step12, step13, step14, step15, step16
}

struct UserData: Codable {
    var uid: String = ""
    var username: String = ""
    var avatar: Data? = nil
    var isUsingForSelf: Bool = true
    var birthday: Date = Date()
    var state: String = ""
    var periodLength: Int = 7
    var cycleLength: Int = 7
    var lastPeriodStartDate: Date = Date()
    var lastPeriodEndDate: Date = Date()
    var isTryingToConceive: Bool = false
    var mood: Double = 1.0
    var symptoms: [String] = []
    var partnerMode: Bool = false
    var partnerUid: String = ""
    var code: String = ""
    var isComplete: Bool = false
}

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .start
    
    @Published var userData = UserData()
    
    func goToNextStep() {
        if let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = nextStep
        }
    }
    
    func goToPreviousStep() {
        if let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1) {
            currentStep = previousStep
        }
    }
    
    func completeOnboarding() {
        guard let user = Auth.auth().currentUser else {
            print("No Firebase user found")
            return
        }

        self.userData.isComplete = true
        self.submitUserData(uid: user.uid)
    }

    func generateInviteCode(length: Int = 6) {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let code = String((0..<length).map { _ in characters.randomElement()! })
        userData.code = code
    }
    
    func setAvatar(image: UIImage) {
        if let imageData = image.pngData() {
            userData.avatar = imageData
        }
    }

    func submitUserData(uid: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedBirthday = dateFormatter.string(from: userData.birthday)
        let formattedLastPeriodStartDate = dateFormatter.string(from: userData.lastPeriodStartDate)
        let formattedLastPeriodEndDate = dateFormatter.string(from: userData.lastPeriodEndDate)
        
        let userDataDictionary: [String: Any] = [
            "uid": Auth.auth().currentUser?.uid ?? "unknown uid",
            "username": userData.username,
            "avatar": userData.avatar?.base64EncodedString(),
            "isUsingForSelf": userData.isUsingForSelf,
            "birthday": formattedBirthday,
            "periodLength": userData.periodLength,
            "cycleLength": userData.cycleLength,
            "lastPeriodStartDate": formattedLastPeriodStartDate,
            "lastPeriodEndDate": formattedLastPeriodEndDate,
            "isTryingToConceive": userData.isTryingToConceive,
            "mood": userData.mood,
            "symptoms": userData.symptoms,
            "partnerMode": userData.partnerMode,
            "partnerUid": userData.partnerUid,
            "code": userData.code,
            "isComplete": userData.isComplete
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userDataDictionary) else {
            print("Error serializing user data to JSON")
            return
        }

        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")


        //sendUserData(jsonData: jsonData, uid: user.uid)
    }

    private func sendUserData(jsonData: Data, uid: String) {
        guard let url = URL(string: "http://api.asone.life/userInfo/\(uid)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
