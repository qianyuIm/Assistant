//
//  CGPointExtensions.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

extension CGPoint: AppExtensionCompatible {}

extension AppExtensionWrapper where Base == CGPoint {
    static func inCircle(_ circle: CGRect,
                         for angle: CGFloat,
                         margin: CGFloat = 0.0) -> CGPoint {
        return CGPoint(
            x: circle.midX + (circle.app.radius - margin) * cos(angle),
            y: circle.midY + (circle.app.radius - margin) * sin(angle)
        )
    }
}
