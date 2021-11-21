//
//  AppAnalogClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class AppAnalogClockView: UIView {
    lazy var bgCircleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    lazy var hourHandLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
//        layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        return layer
    }()
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            configLayer()
        }
    }
    var dateSource: Date = Date() {
        didSet {
            var houe = dateSource.hour
            let minute = dateSource.minute
            let second = dateSource.second
            
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgCircleLayer.frame = bounds
        let hourHandWidth = attributes.clockStyle.hourHandSize.width
        let hourHandHeight = attributes.clockStyle.hourHandSize.height
        hourHandLayer.frame = CGRect(x: 0, y: 0, width: hourHandWidth, height: hourHandHeight)
        hourHandLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        hourHandLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

extension AppAnalogClockView {
    func setupUI() {
        layer.addSublayer(bgCircleLayer)
        layer.addSublayer(hourHandLayer)
    }
    func configLayer() {
        if let bgImageName = attributes.clockStyle.backgroundImageName {
            bgCircleLayer.contents = UIImage(named: bgImageName)?.cgImage
        } else {
            bgCircleLayer.backgroundColor = UIColor.app.color(hexString: attributes.clockStyle.backgroundHexColorString).cgColor
        }
        if let hourImageName = attributes.clockStyle.hourHandImageName {
            hourHandLayer.contents = UIImage(named: hourImageName)?.cgImage
        } else {
            hourHandLayer.backgroundColor = UIColor.app.color(hexString: attributes.clockStyle.hourHandHexColorString).cgColor
        }
    }
}
