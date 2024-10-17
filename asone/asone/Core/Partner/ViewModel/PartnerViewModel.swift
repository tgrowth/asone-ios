//
//  PartnerViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/16/24.
//

import Foundation
import Combine

class PartnerViewModel: ObservableObject {
    @Published var dayNames: [String] = []
    @Published var dayDates: [String] = []
    @Published var phaseInfo: String = ""
    @Published var feedbackPrompt: String = ""
    @Published var tips: [(tipNumber: Int, text: String)] = []
    
    init() {
        // Populate with default data or fetch from a data source
        dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        dayDates = ["30", "1", "2", "3", "4", "5", "6"]
        phaseInfo = "You're in the luteal phase."
        feedbackPrompt = "How is your partner responding to your needs during this week?"
        tips = [
            (1, "Thank your partner for being understanding during your luteal phase."),
            (2, "Feeling a bit emotional? Share your thoughts with your partner.")
        ]
    }
}
