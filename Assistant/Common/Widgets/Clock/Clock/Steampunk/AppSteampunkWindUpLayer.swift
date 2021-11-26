//
//  AppSteampunkWindUpLayer.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

class AppSteampunkWindUpLayer: CAShapeLayer {
    func bezierPath(in rect: CGRect) -> UIBezierPath {
        var bezierPath = UIBezierPath()
        addOutline(to: &bezierPath, rect: rect)
        addCircles(to: &bezierPath, rect: rect)
        return bezierPath
    }
    func addOutline(to bezierPath: inout UIBezierPath, rect: CGRect) {
        let radius = min(rect.width, rect.height) / 2
        let thickness = radius * 1/6
        let holeRadius = radius * 1/3
        let holeCenterY = holeRadius / 2 + radius / 2 + thickness

        let leftHole = CGRect.app.circle(center: CGPoint(x: radius * 1/2, y: holeCenterY), radius: holeRadius)
        let rightHole = CGRect.app.circle(center: CGPoint(x: radius * 3/2, y: holeCenterY), radius: holeRadius)
        let topHole = CGRect.app.circle(center: CGPoint(x: radius, y: holeRadius/2 + thickness), radius: holeRadius/2)

        bezierPath.move(to: CGPoint(x: rect.width * 1/3, y: rect.maxY))
        bezierPath.addLine(to: CGPoint(x: rect.width * 1/3, y: leftHole.maxY + thickness))
        bezierPath.addArc(withCenter: leftHole.app.center, radius: leftHole.app.radius + thickness, startAngle: .pi/2, endAngle: .pi * 3/2, clockwise: true)
        bezierPath.addArc(withCenter: topHole.app.center, radius: topHole.app.radius + thickness, startAngle: .pi, endAngle: .zero, clockwise: true)
        bezierPath.addArc(withCenter: rightHole.app.center, radius: rightHole.app.radius + thickness, startAngle: .pi * 3 / 2, endAngle: .pi / 2, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: rect.width * 2/3, y: rightHole.maxY + thickness))
        bezierPath.addLine(to: CGPoint(x: rect.width * 2/3, y: rect.maxY))
        bezierPath.close()
    }
    func addCircles(to bezierPath: inout UIBezierPath, rect: CGRect) {
        let thickness = rect.app.radius * 1/6
        let holeRadius = rect.app.radius * 1/3
        let holeCenterY = holeRadius/2 + rect.app.radius/2 + thickness
        let leftHole = CGRect.app.circle(center: CGPoint(x: rect.app.radius * 1/2, y: holeCenterY), radius: holeRadius)
        let rightHole = CGRect.app.circle(center: CGPoint(x: rect.app.radius * 3/2, y: holeCenterY), radius: holeRadius)
        let topHole = CGRect.app.circle(center: CGPoint(x: rect.app.radius, y: holeRadius/2 + thickness), radius: holeRadius/2)

        bezierPath.app.addCircle(leftHole)
        bezierPath.app.addCircle(rightHole)
        bezierPath.app.addCircle(topHole)
    }
}
