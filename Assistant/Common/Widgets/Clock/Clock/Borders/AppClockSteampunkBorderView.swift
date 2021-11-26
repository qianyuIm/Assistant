//
//  AppClockClassicBorder.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit

class AppClockSteampunkBorderView: UIView {
    static let borderWidthRatio: CGFloat = 1/80
    var oldBounds = CGRect.zero
    lazy var greatShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    lazy var windUpLayer: AppSteampunkWindUpLayer = {
        let layer = AppSteampunkWindUpLayer()
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
                windUpLayer.strokeColor = clockAttributes?.borderColor.color(for: traitCollection).cgColor
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

        let windUpLayerRect = CGRect(x: 0, y: 0, width: radius * 1/4, height: radius * 1/4)
        windUpLayer.path = windUpLayer.bezierPath(in: windUpLayerRect).cgPath
        windUpLayer.setAffineTransform(.init(rotationAngle: -.pi / 4))
        windUpLayer.position = CGPoint.app.inCircle(bounds,
                                                    for: .pi * 5/4,
                                                    margin: -radius * 1/4)
        windUpLayer.lineWidth = greatLineWidth
        windUpLayer.fillColor = UIColor.clear.cgColor
        windUpLayer.strokeColor = clockAttributes.borderColor.color(for: traitCollection).cgColor
        layer.addSublayer(windUpLayer)
    }
}
