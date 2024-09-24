//
//  User.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
}
