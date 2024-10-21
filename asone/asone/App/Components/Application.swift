//
//  Application.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/25/24.
//

import SwiftUI
import UIKit

final class Application_utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
