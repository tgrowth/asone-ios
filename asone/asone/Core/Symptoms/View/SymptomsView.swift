//
//  SymptomsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/13/24.
//

import SwiftUI

struct SymptomsView: View {
    @StateObject private var viewModel = SymptomsViewModel()
    @State private var selectedSymptoms: [String: Bool] = [:]

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading symptoms...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    // Grouping symptoms by category
                    let groupedSymptoms = Dictionary(grouping: viewModel.symptoms, by: { $0.type })

                    ForEach(groupedSymptoms.sorted(by: { $0.key < $1.key }), id: \.key) { category, symptoms in
                        SymptomSection(title: category, symptoms: symptoms.map { $0.name }, selectedSymptoms: $selectedSymptoms)
                    }
                }

            }
            
            if selectedSymptoms.count != 0 {
                Button(action: {
                    Task { await applySelectedSymptoms() }
                }) {
                    Text("Apply")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            Task { await viewModel.loadSymptoms() }
        }
    }

    private func applySelectedSymptoms() async {
        for (symptomName, isSelected) in selectedSymptoms where isSelected {
            if let symptom = viewModel.symptoms.first(where: { $0.name == symptomName }) {
                await viewModel.addSymptoms(uid: AuthService.shared.userSession?.uid ?? "unknown uid", symptomId: symptom.id)
            }
        }
    }
}

// SymptomSection View for each category
struct SymptomSection: View {
    var title: String
    var symptoms: [String]
    @Binding var selectedSymptoms: [String: Bool]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 5), spacing: 20) {
                ForEach(symptoms, id: \.self) { symptom in
                    Button(action: {
                        selectedSymptoms[symptom] = !(selectedSymptoms[symptom] ?? false)
                    }) {
                        VStack {
                            Image(systemName: "cloud.fill")
                                .font(.system(size: 24))
                                .foregroundColor(selectedSymptoms[symptom] ?? false ? .black : .gray)
                            Text(symptom)
                                .font(.system(size: 8))
                                .foregroundColor(.black)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 8)
    }
}

#Preview {
    SymptomsView()
}
