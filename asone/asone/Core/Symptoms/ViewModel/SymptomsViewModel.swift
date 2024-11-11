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
    @Published var symptomLog: SymptomLog?
    @Published var markedSymptoms: [MarkedSymptom] = []

    struct MarkedSymptom: Identifiable {
        let id: Int
        let type: String
        let name: String
        var isLogged: Bool
    }

    @MainActor
    func loadSymptoms() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedSymptoms = try await SymptomService.shared.fetchSymptoms()
            self.symptoms = fetchedSymptoms
            self.updateMarkedSymptoms()
            self.isLoading = false
        } catch {
            self.errorMessage = "Failed to load symptoms: \(error.localizedDescription)"
            self.isLoading = false
        }
    }

    @MainActor
    func logSymptoms(symptomLog: SymptomLog) async {
        isLoading = true
        errorMessage = nil

        do {
            try await SymptomService.shared.sendSymptomLog(symptomLog)
            isLoading = false
        } catch {
            self.errorMessage = "Failed to log symptoms: \(error.localizedDescription)"
            isLoading = false
        }
    }

    @MainActor
    func loadSymptomsForDate(uid: String, date: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedSymptomLog = try await SymptomService.shared.fetchSymptomsForDate(uid: uid, date: date)
            self.symptomLog = fetchedSymptomLog
            updateMarkedSymptoms()  // Update the marked symptoms if log exists
            isLoading = false
        } catch {
            // No log exists for the date, so set symptomLog to nil and allow logging
            self.symptomLog = nil
            updateMarkedSymptoms()  // Clear any marked symptoms
            self.isLoading = false
            self.errorMessage = nil  // Clear error if we expect this case
        }
    }

    private func updateMarkedSymptoms() {
        guard let symptomLog = symptomLog else {
            // If no log exists, mark all symptoms as unlogged
            self.markedSymptoms = symptoms.map { MarkedSymptom(id: $0.id, type: $0.type, name: $0.name, isLogged: false) }
            return
        }

        // Mark the symptoms that are logged based on the log
        let loggedSymptomIds = Set(symptomLog.symptoms)
        self.markedSymptoms = symptoms.map { symptom in
            let isLogged = loggedSymptomIds.contains(symptom.id)
            return MarkedSymptom(id: symptom.id, type: symptom.type, name: symptom.name, isLogged: isLogged)
        }
    }
}
