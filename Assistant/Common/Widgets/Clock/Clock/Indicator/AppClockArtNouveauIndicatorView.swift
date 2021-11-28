//
//  AppClockClassicBorder.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit
import SnapKit

private let marginRatio: CGFloat = 1/12

class AppClockArtNouveauIndicatorView: UIView {
    var oldBounds = CGRect.zero
    private var _clockAttributes: AppWidgetAttributes.ClockAttributes?
    var clockAttributes: AppWidgetAttributes.ClockAttributes? {
        didSet {
            if _clockAttributes == clockAttributes {
                return
            }
            _clockAttributes = clockAttributes
            textsView.clockAttributes = _clockAttributes
            updateIndicatorLayer(with: clockAttributes!)
        }
    }
    private lazy var textsView: AppClockArtNouveauIndicatorTextsView = {
        let textsView = AppClockArtNouveauIndicatorTextsView(with: marginRatio)
        return textsView
    }()
    lazy var sunIndicatorLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if oldBounds == bounds || _clockAttributes == nil { return }
        oldBounds = bounds
        updateIndicatorLayer(with: clockAttributes!)
    }
    func updateIndicatorLayer(with clockAttributes: AppWidgetAttributes.ClockAttributes) {
        sunIndicatorLayer.path = nil
        sunIndicatorLayer.removeFromSuperlayer()
        if clockAttributes.isMinuteIndicatorsShown {
            sunIndicatorLayer.strokeColor = clockAttributes.borderColor.color(for: traitCollection).cgColor
            sunIndicatorLayer.path = sunBezierPath(in: bounds).cgPath
            layer.addSublayer(sunIndicatorLayer)
        }
    }
    func setupUI() {
        addSubview(textsView)
        textsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func sunBezierPath(in rect: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let circle = rect
        let startPoint = CGPoint.app.inCircle(circle, for: -.pi * 1/2, margin: circle.app.radius * 1/3)
        bezierPath.move(to: startPoint)
        for minute in 0...60 {
            let pointAngle =  -.pi * 1/2 + CGFloat(minute) / 30 * .pi
            let point = CGPoint.app.inCircle(circle, for: pointAngle, margin: circle.app.radius * 1/3)
            let controlAngle = -.pi * 1/2 + CGFloat(minute) / 30 * .pi - 1/120
            let control = CGPoint.app.inCircle(circle, for: controlAngle, margin: circle.app.radius * 1/2)
            bezierPath.addQuadCurve(to: point, controlPoint: control)
        }
        return bezierPath
    }
}
private class AppClockArtNouveauIndicatorTextsView: UIView {
    var marginRatio: CGFloat
    let numbers = ["XII", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI"]
    let limitedNumbers = ["XII", "III", "VI", "IX"]
    let textFontRatio: CGFloat = 1/8
    var numberLabels: [UILabel] = []
    private var _clockAttributes: AppWidgetAttributes.ClockAttributes?
    var clockAttributes: AppWidgetAttributes.ClockAttributes? {
        didSet {
            if _clockAttributes == clockAttributes || clockAttributes == nil {
                return
            }
            if _clockAttributes?.isLimitedHoursShown != clockAttributes?.isLimitedHoursShown {
                setupUI()
            }
            _clockAttributes = clockAttributes
            setNeedsLayout()
        }
    }
    init(with marginRatio: CGFloat) {
        self.marginRatio = marginRatio
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        numberLabels.forEach {
            $0.removeFromSuperview()
        }
        numberLabels.removeAll()
        for number in hourNums(for: clockAttributes?.isLimitedHoursShown ?? false) {
            let label = UILabel()
            label.text = number
            label.textAlignment = .center
            addSubview(label)
            numberLabels.append(label)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard clockAttributes != nil else {
            return
        }
        let fontSize = (bounds.app.radius * textFontRatio).rounded()
        let margin = bounds.app.radius * marginRatio
        let font = QYFont.font(clockAttributes!.fontName.rawValue, fontSize: fontSize)
        let textColor = clockAttributes!.indicatorColor.color(for: traitCollection)
        for (index, textLabel) in numberLabels.enumerated() {
            textLabel.font = font
            textLabel.textColor = textColor
            let angle = hourAngle(for: clockAttributes!.isLimitedHoursShown, index: CGFloat(index))
            textLabel.frame = CGRect(x: 0, y: 0, width: margin * 3, height: margin * 3)
            textLabel.app.addRoundCorners(.allCorners, radius: margin * 3 / 2)
            textLabel.app.addBorder(textColor, borderWidth: 1)
            textLabel.center = CGPoint.app.inCircle(bounds, for: angle, margin: margin * 2)
        }
    }
    func hourNums(for isLimitedHoursShown: Bool) -> [String] {
        if isLimitedHoursShown {
            return limitedNumbers
        }
        return numbers
    }
    func hourAngle(for isLimitedHoursShown: Bool,
                   index: CGFloat) -> CGFloat {
        if isLimitedHoursShown {
            return -.pi * 1/2 + index / 2 * .pi
        }
        return -.pi * 1/2 + index / 6 * .pi
    }
}
