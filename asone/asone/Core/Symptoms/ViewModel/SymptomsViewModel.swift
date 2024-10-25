//
//  SymptomsViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/13/24.
//


import Foundation

class SymptomsViewModel: ObservableObject {
    @Published var symptoms: [Symptom] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @MainActor
    func loadSymptoms() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedSymptoms = try await SymptomService.shared.fetchSymptoms()
            self.symptoms = fetchedSymptoms
            self.isLoading = false
        } catch {
            self.errorMessage = "Failed to load symptoms: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    @MainActor
    func addSymptoms(uid: String, symptomId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await SymptomService.shared.sendSymptoms(uid: uid, symptomId: symptomId)
            print("Symptom \(symptomId) successfully added for user \(uid).")
            isLoading = false
        } catch {
            self.errorMessage = "Failed to add symptom: \(error.localizedDescription)"
            isLoading = false
        }
    }
}
