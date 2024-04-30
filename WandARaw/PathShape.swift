//
//  PathShape.swift
//  WandARaw
//
//  Created by Glenn Leonali on 30/04/24.
//

import SwiftUI

struct PathShape: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()

        for i in 0..<360 {
            let angle = Angle(degrees: Double(i))
            let x = center.x + radius * cos(angle.radians)
            let y = center.y + radius * sin(angle.radians)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        for i in 0..<360 {
            let angle = Angle(degrees: Double(i))
            let x1 = center.x + radius * cos(angle.radians)
            let y1 = center.y + radius * sin(angle.radians)
            let x2 = center.x + (radius - 20) * cos(angle.radians)
            let y2 = center.y + (radius - 20) * sin(angle.radians)
            path.addQuadCurve(to: CGPoint(x: x2, y: y2), control: CGPoint(x: x1, y: y1))
        }

        return path
    }
}
