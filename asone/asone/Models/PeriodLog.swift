//
//  PeriodLog.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import Foundation

struct PeriodLog: Decodable, Encodable {
    let uid: String
    let periodLogs: [String]

    func dateObjects() -> [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return periodLogs.compactMap { dateFormatter.date(from: $0) }
    }
}
