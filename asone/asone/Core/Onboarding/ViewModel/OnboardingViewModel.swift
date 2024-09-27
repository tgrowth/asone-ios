import SwiftUI

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
        userData.isComplete = true
        print("Onboarding Completed with Data: \(userData)")
    }
    
    func generateInviteCode(length: Int = 6) {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let inviteCode = String((0..<length).map { _ in characters.randomElement()! })
        userData.inviteCode = inviteCode
    }
}
