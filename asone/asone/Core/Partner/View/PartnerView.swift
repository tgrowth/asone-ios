//
//  PartnerView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/16/24.
//

import SwiftUI

struct PartnerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Date Indicator
                HStack(spacing: 8) {
                    ForEach(0..<7) { day in
                        VStack {
                            Text(getDayName(for: day))
                                .font(.footnote)
                            Text(getDayDate(for: day))
                                .font(.subheadline)
                        }
                        .frame(width: 40, height: 40)
                        .background(day == 2 ? Color.black : Color.gray.opacity(0.2))
                        .foregroundColor(day == 2 ? .white : .black)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 10)

                // Phase Information
                VStack(alignment: .leading, spacing: 8) {
                    Text("You're in the luteal phase.")
                        .font(.subheadline)
                        .bold()
                    Text("You may feel a bit tired and irritable. This is a great time to communicate openly with your partner about your needs, while showing appreciation for their patience and support.")
                        .font(.footnote)
                }
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal, 10)

                // Feedback Section
                VStack(alignment: .leading) {
                    Text("Give feedback to John")
                        .font(.subheadline)
                    TextField("Write a few nice words to John or thank him for his efforts", text: .constant(""))
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 10)

                // Tips Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Tips for you")
                        .font(.subheadline)
                    
                    HStack(spacing: 8) {
                        TipView(tipNumber: 1, text: "Thank your partner for being understanding during your luteal phase. Even a simple \"I appreciate you\" can make a difference.")
                        TipView(tipNumber: 2, text: "Feeling a bit emotional? Share your thoughts with your partner—they'll appreciate the trust you put in them.")
                    }
                }
                .padding(.horizontal, 10)

                // Partner Feedback Section
                VStack(alignment: .leading) {
                    Text("Your feedback")
                        .font(.subheadline)
                    Text("How is your partner responding to your needs during this week?")
                        .font(.footnote)
                    
                    // Feedback buttons (circles for response options)
                    HStack(spacing: 12) {
                        ForEach(0..<5) { _ in
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                    }
                }
                .padding(.horizontal, 10)
            }.navigationTitle("John is connected")
        }
    }
    
    // Helper function for days
    func getDayName(for index: Int) -> String {
        let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return days[index]
    }
    
    func getDayDate(for index: Int) -> String {
        let dates = ["30", "1", "2", "3", "4", "5", "6"]
        return dates[index]
    }
}

struct TipView: View {
    var tipNumber: Int
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tip #\(tipNumber)")
                .font(.footnote)
                .bold()
            Text(text)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true) // Allows text to wrap
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PartnerView()
}
