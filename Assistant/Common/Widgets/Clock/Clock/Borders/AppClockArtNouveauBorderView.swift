//
//  AppClockClassicBorder.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

class AppClockArtNouveauBorderView: UIView {
    static let borderWidthRatio: CGFloat = 1/50
    static let innerCircleScale: CGFloat = 9/10
    var oldBounds = CGRect.zero
    lazy var greatShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    lazy var smallShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    private var _clockAttributes: AppWidgetAttributes.ClockAttributes?
    var clockAttributes: AppWidgetAttributes.ClockAttributes? {
        didSet {
            if _clockAttributes == clockAttributes || clockAttributes == nil {
                return
            }
            _clockAttributes = clockAttributes
            if _clockAttributes?.displayStyle != clockAttributes?.displayStyle {
                updateShapeLayer(with: _clockAttributes!)
            }
            if _clockAttributes?.borderColor != clockAttributes?.borderColor {
                greatShapeLayer.strokeColor = clockAttributes?.borderColor.color(for: traitCollection).cgColor
                smallShapeLayer.strokeColor = clockAttributes?.borderColor.color(for: traitCollection).cgColor
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
        let greatBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        greatShapeLayer.path = greatBezierPath.cgPath
        let greatLineWidth = radius * Self.borderWidthRatio
        greatShapeLayer.lineWidth = greatLineWidth
        greatShapeLayer.fillColor = UIColor.clear.cgColor
        greatShapeLayer.strokeColor = clockAttributes.borderColor.color(for: traitCollection).cgColor
        layer.addSublayer(greatShapeLayer)

        let smallBezierPath = UIBezierPath(arcCenter: center, radius: radius * Self.innerCircleScale, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        smallBezierPath.apply(.init(translationX: 0, y: radius * (1 - Self.innerCircleScale)))
        smallShapeLayer.path = smallBezierPath.cgPath
        let smallLineWidth = radius * Self.borderWidthRatio / 2
        smallShapeLayer.lineWidth = smallLineWidth
        smallShapeLayer.fillColor = UIColor.clear.cgColor
        smallShapeLayer.strokeColor = clockAttributes.borderColor.color(for: traitCollection).cgColor
        layer.addSublayer(smallShapeLayer)

    }
}
