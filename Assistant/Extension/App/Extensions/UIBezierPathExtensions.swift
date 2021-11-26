//
//  UIBezierPathExtensions.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

extension AppExtensionWrapper where Base == UIBezierPath {
    func addCircle(_ circle: CGRect) {
        base.move(to: CGPoint(x: circle.maxX, y: circle.app.center.y))
        base.addArc(withCenter: circle.app.center, radius: circle.app.radius, startAngle: .zero, endAngle: .pi * 2, clockwise: true)
    }
}
