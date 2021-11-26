//
//  AppClockClassicBorder.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

class AppClockClassicBorderView: UIView {
    var oldBounds = CGRect.zero
    static let borderWidthRatio: CGFloat = 1/35
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    private var _clockAttributes: AppWidgetAttributes.ClockAttributes?
    var clockAttributes: AppWidgetAttributes.ClockAttributes? {
        didSet {
            if _clockAttributes == clockAttributes {
                return
            }
            _clockAttributes = clockAttributes
            if _clockAttributes?.displayStyle != clockAttributes?.displayStyle {
                updateShapeLayer(with: _clockAttributes!)
            }
            if _clockAttributes?.borderColor != clockAttributes?.borderColor {
                shapeLayer.strokeColor = clockAttributes?.borderColor.color(for: traitCollection).cgColor
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if oldBounds == bounds || _clockAttributes == nil { return }
        oldBounds = bounds
        updateShapeLayer(with: _clockAttributes!)
    }
    func updateShapeLayer(with clockAttributes: AppWidgetAttributes.ClockAttributes) {
        let radius = min(bounds.width, bounds.height) / 2
        let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = bezierPath.cgPath
        let lineWidth = radius * Self.borderWidthRatio
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = clockAttributes.borderColor.color(for: traitCollection).cgColor
        layer.addSublayer(shapeLayer)
    }
}
