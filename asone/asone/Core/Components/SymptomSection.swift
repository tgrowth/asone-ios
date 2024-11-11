//
//  SymptomSection.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 11/7/24.
//

import SwiftUI

struct SymptomSection: View {
    var title: String
    var symptoms: [SymptomsViewModel.MarkedSymptom]
    @Binding var selectedSymptoms: [String: Bool]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            // Horizontal ScrollView for symptoms
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(symptoms) { symptom in
                        Button(action: {
                            selectedSymptoms[symptom.name] = !(selectedSymptoms[symptom.name] ?? false)
                        }) {
                            VStack {
                                Image(systemName: "cloud.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(symptom.isLogged || (selectedSymptoms[symptom.name] ?? false) ? .black : .gray)
                                Text(symptom.name)
                                    .font(.system(size: 8))
                                    .foregroundColor(.black)
                            }
                            .padding(8)
                            .background(symptom.isLogged ? Color.teal : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 8)
    }
}
