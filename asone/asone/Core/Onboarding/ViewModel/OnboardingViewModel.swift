import SwiftUI
import FirebaseAuth

enum OnboardingStep: Int, CaseIterable {
    case start, step1, step2, step3, step4, step5, step6, step7, step8, step9, step10, step11, step12, step13, step14, step15, step16
}

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .start
    @Published var userData: UserData = UserData()
    @Published var symptoms: [Symptom] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
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
        Task {
            await submitUserData(uid: user.uid)
        }
    }

//    func setAvatar(image: UIImage) {
//        if let imageData = image.pngData() {
//            userData.avatar = imageData
//        }
//    }

    func submitUserData(uid: String) async {
        let userDataDictionary: [String: Any] = [
            "uid": uid,
            "username": userData.username,
            "avatar": userData.avatar,
            "isUsingForSelf": userData.isUsingForSelf,
            "birthday": userData.birthday.toString(),
            "state": userData.state,
            "periodLength": userData.periodLength,
            "cycleLength": userData.cycleLength,
            "lastPeriodStartDate": userData.lastPeriodStartDate.toString(),
            "lastPeriodEndDate": userData.lastPeriodEndDate.toString(),
            "isTryingToConceive": userData.isTryingToConceive,
            "mood": userData.mood,
            "symptoms": userData.symptoms,
            "partnerMode": userData.partnerMode,
            "partnerUid": userData.partnerUid,
            "code": userData.code,
            "isComplete": userData.isComplete
        ]

        do {
            try await UserService.shared.sendUserData(userDataDictionary: userDataDictionary)
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to send user data: \(error.localizedDescription)"
            }
            print(error)
        }
    }

    @MainActor
    func loadSymptoms() async {
        isLoading = true
        errorMessage = nil

        do {
            self.symptoms = try await SymptomService.shared.fetchSymptoms()
        } catch {
            self.errorMessage = "Failed to load symptoms: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
