//
//  AppAnalogClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class AppAnalogClockView: UIView {
    /// 背景
    lazy var bgCircleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    /// 大刻度layer
    lazy var largeGraduationLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    /// 大刻度layer
    lazy var smallGraduationLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    /// 时针
    lazy var hourHandLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    /// 分针
    lazy var minutesHandLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    /// 秒针
    lazy var secondHandLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    lazy var fontView: UIView = {
        let view = UIView()
        return view
    }()
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes? {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            updateLayer(with: _attributes!)
        }
    }
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 30

    var dateSource: Date = Date() {
        didSet {
            hour = (dateSource.hour > 12) ? dateSource.hour - 12 : dateSource.hour
            minute = dateSource.minute
            second = dateSource.second

            let secondAngle = degree2Radians(degress: second)
            let minuteAngle = degree2Radians(degress: minute)
            let hourAngle = degreeFromHours(hours: hour, minutes: minute)

            secondHandLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1)
            minutesHandLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
            hourHandLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
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
    }
}

extension AppAnalogClockView {
    func setupUI() {
        layer.addSublayer(bgCircleLayer)
        layer.addSublayer(hourHandLayer)
        layer.addSublayer(minutesHandLayer)
        layer.addSublayer(secondHandLayer)
    }
    func updateLayer(with attributes: AppWidgetAttributes) {
        if let bgImageName = attributes.analogClockStyle.backgroundImageName {
            bgCircleLayer.contents = UIImage(named: bgImageName)?.cgImage
        } else {
            updateBackgroundStyle(with: attributes)
        }
        if let hourImageName = attributes.analogClockStyle.hourHandImageName {
            hourHandLayer.contents = UIImage(named: hourImageName)?.cgImage
        } else {
            let hourHandSize = attributes.analogClockStyle.size.hourHandSize
            let hourHandRect = CGRect(x: -hourHandSize.width / 2, y: -hourHandSize.height, width: hourHandSize.width, height: hourHandSize.height)
            let hourCornerRadius = hourHandRect.width / 2
            let hourPath = UIBezierPath(roundedRect: hourHandRect, cornerRadius: hourCornerRadius)
            hourHandLayer.path = hourPath.cgPath
            hourHandLayer.fillColor = UIColor.app.color(hexString: attributes.analogClockStyle.hourHandHexColorString).cgColor
            hourHandLayer.position = attributes.analogClockStyle.size.circleCenter
        }
        if let minutesHandImageName = attributes.analogClockStyle.minutesHandImageName {
            minutesHandLayer.contents = UIImage(named: minutesHandImageName)?.cgImage
        } else {
            let minutesHandSize = attributes.analogClockStyle.size.minutesHandSize
            let minutesHandRect = CGRect(x: -minutesHandSize.width / 2, y: -minutesHandSize.height, width: minutesHandSize.width, height: minutesHandSize.height)
            let minutesCornerRadius = minutesHandRect.width / 2
            let minutesPath = UIBezierPath(roundedRect: minutesHandRect, cornerRadius: minutesCornerRadius)
            minutesHandLayer.path = minutesPath.cgPath
            minutesHandLayer.fillColor = UIColor.app.color(hexString: attributes.analogClockStyle.minutesHandHexColorString).cgColor
            minutesHandLayer.position = attributes.analogClockStyle.size.circleCenter
        }
        if let secondsHandImageName = attributes.analogClockStyle.secondsHandImageName {
            secondHandLayer.contents = UIImage(named: secondsHandImageName)?.cgImage
        } else {
            let secondsHandSize = attributes.analogClockStyle.size.secondsHandSize
            let secondsPath = UIBezierPath(rect: CGRect(x: -secondsHandSize.width / 2, y: -secondsHandSize.height, width: secondsHandSize.width, height: secondsHandSize.height))
            secondHandLayer.path = secondsPath.cgPath
            secondHandLayer.fillColor = UIColor.app.color(hexString: attributes.analogClockStyle.secondsHexColorString).cgColor
            secondHandLayer.position = attributes.analogClockStyle.size.circleCenter
        }
    }
}
private extension AppAnalogClockView {
    func degree2Radians(degress: Int) -> CGFloat {
        return CGFloat(degress * 6) * .pi / 180.0
    }
    func degreeFromHours(hours: Int, minutes: Int) -> CGFloat {
        return CGFloat(hours * 30 + minutes/2) * .pi / 180.0
    }
}
private extension AppAnalogClockView {
    func updateBackgroundStyle(with attributes: AppWidgetAttributes) {
        let bgCirclePath = UIBezierPath(arcCenter: attributes.analogClockStyle.size.circleCenter, radius: attributes.analogClockStyle.size.circleRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        bgCircleLayer.fillColor = UIColor.app.color(hexString: attributes.analogClockStyle.backgroundHexColorString).cgColor
        bgCircleLayer.path = bgCirclePath.cgPath
        switch attributes.analogClockStyle.backgroundStyle {
        case .style1: updateBackgroundStyle1(with: attributes)
        case .style2: updateBackgroundStyle2(with: attributes)
        case .style3: updateBackgroundStyle3(with: attributes)
        default: break
        }
    }
    func updateBackgroundStyle1(with attributes: AppWidgetAttributes) {
        let radius = attributes.analogClockStyle.size.circleRadius - attributes.analogClockStyle.size.backgroundMargen
        largeGraduationLayer.sublayers?.removeAll()
        largeGraduationLayer.removeFromSuperlayer()
        for index in 0..<12 {
            addGraduationLine(attributes: attributes, radius: radius, index: index, large: true)
        }
        self.layer.insertSublayer(largeGraduationLayer, above: bgCircleLayer)
    }
    func updateBackgroundStyle2(with attributes: AppWidgetAttributes) {
        updateBackgroundStyle1(with: attributes)
        let radius = attributes.analogClockStyle.size.circleRadius - attributes.analogClockStyle.size.backgroundMargen
        smallGraduationLayer.sublayers?.removeAll()
        smallGraduationLayer.removeFromSuperlayer()
        for index in 0..<60 {
            addGraduationLine(attributes: attributes, radius: radius, index: index, large: false)
        }
        self.layer.insertSublayer(smallGraduationLayer, above: bgCircleLayer)
    }
    func updateBackgroundStyle3(with attributes: AppWidgetAttributes) {
        updateBackgroundStyle2(with: attributes)
        let radius = attributes.analogClockStyle.size.circleRadius - attributes.analogClockStyle.size.textMargen
        for subview in fontView.subviews {
            subview.removeFromSuperview()
        }
        fontView.layer.removeFromSuperlayer()
        fontView.removeFromSuperview()
        for index in 0..<12 {
            addTimeText(attributes: attributes, radius: radius, index: index)
        }
        self.addSubview(fontView)
        self.layer.insertSublayer(fontView.layer, above: bgCircleLayer)
    }
    /// 添加刻度
    func addGraduationLine(attributes: AppWidgetAttributes,
                           radius: CGFloat,
                           index: Int,
                           large: Bool) {
        if large == false {
            if index % 5 == 0 { return }
        }
        let largeGraduationSize = attributes.analogClockStyle.size.largeGraduationSize
        let smallGraduationSize = attributes.analogClockStyle.size.smallGraduationSize
        let circleCenter = attributes.analogClockStyle.size.circleCenter
        let circleRadius = attributes.analogClockStyle.size.circleRadius

        let denominator: CGFloat = large ? 6.0 : 30.0
        let lineLength = large ? largeGraduationSize.height : smallGraduationSize.height
        let linewidth: CGFloat = large ? largeGraduationSize.width : smallGraduationSize.width
        let angle = .pi / denominator * Double(index)
        let radio = CGFloat(sin(angle))
        let radio1 = CGFloat(cos(angle))
        let offsetX = circleCenter.x - circleRadius
        let offsetY = circleCenter.y - circleRadius
        let x: CGFloat = radius + radio * radius + attributes.analogClockStyle.size.backgroundMargen + offsetX
        let y: CGFloat = radius - radio1 * radius + attributes.analogClockStyle.size.backgroundMargen + offsetY
        let pp1 = CGPoint(x: 0, y: 0)
        let pp2 = CGPoint(x: 0, y: lineLength)
        let path = UIBezierPath()
        path.move(to: pp1)
        path.addLine(to: pp2)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.position = CGPoint(x: x, y: y)
        layer.lineWidth = linewidth
        layer.lineCap = CAShapeLayerLineCap.round
        layer.transform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
        if large {
            layer.strokeColor = UIColor.app.color(hexString: _attributes!.analogClockStyle.largeGraduationHexColorString).cgColor
            largeGraduationLayer.addSublayer(layer)
        } else {
            layer.strokeColor = UIColor.app.color(hexString: _attributes!.analogClockStyle.smallGraduationHexColorString).cgColor
            smallGraduationLayer.addSublayer(layer)
        }
    }
    /// 添加文字
    func addTimeText(attributes: AppWidgetAttributes,
                     radius: CGFloat,
                     index: Int) {
        let circleCenter = attributes.analogClockStyle.size.circleCenter
        let circleRadius = attributes.analogClockStyle.size.circleRadius
        let textMargen = attributes.analogClockStyle.size.textMargen
        let specialText = "12"
        let angle = .pi / 6.0 * Double(index)
        let radio = CGFloat(sin(angle))
        let radio1 = CGFloat(cos(angle))
        let offsetX = circleCenter.x - circleRadius
        let offsetY = circleCenter.y - circleRadius
        let x: CGFloat = radius + radio * radius + textMargen + offsetX
        let y: CGFloat = radius - radio1 * radius + textMargen + offsetY
        let label = UILabel()
        label.font = attributes.labelStyle.font
        label.textColor = attributes.labelStyle.textColor
        label.text = "\(index)"
        if index == 0 {
            label.text = specialText
        }
        label.sizeToFit()
        let width = label.bounds.width
        let height = label.bounds.height
        if let text = label.text {
            if text.count > 1 && label.text != specialText {
                label.frame = CGRect(x: x - width/2.5, y: y - height/2.5, width: width, height: height)
            } else {
                label.center = CGPoint(x: x, y: y)
            }
        }
        fontView.addSubview(label)
    }
}
