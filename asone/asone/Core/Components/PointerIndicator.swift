//
//  PointerIndicator.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/25/24.
//

import SwiftUI

struct PointerIndicator: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: 0)) // Top point of the triangle
        path.addLine(to: CGPoint(x: width, y: height)) // Bottom right point
        path.addLine(to: CGPoint(x: 0, y: height)) // Bottom left point
        path.closeSubpath() // Close the triangle path
        
        return path
    }
}
