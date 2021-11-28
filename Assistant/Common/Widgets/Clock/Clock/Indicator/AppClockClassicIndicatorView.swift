//
//  AppClockClassicBorder.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit
import SnapKit

private let marginRatio: CGFloat = 2/7
private let hourDotRatio: CGFloat = 2/35
private let minuteDotRatio: CGFloat = 1/35

class AppClockClassicIndicatorView: UIView {
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
    private lazy var textsView: AppClockClassicIndicatorTextsView = {
        let textsView = AppClockClassicIndicatorTextsView(with: marginRatio)
        return textsView
    }()
    lazy var hourIndicatorLayer: AppClockIndicatorLayer = {
        let layer = AppClockIndicatorLayer()
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
        let radius = bounds.app.radius
        if let layers = layer.sublayers {
            for sublayer in layers {
                if let indicatorLayer = sublayer as? AppClockIndicatorLayer {
                    indicatorLayer.removeFromSuperlayer()
                }
            }
        }
        if clockAttributes.isHourIndicatorsShown {
            for index in 0..<13 {
                let angle = -.pi * 1/2 + CGFloat(index) / 6 * .pi
                let arcCenter = CGPoint.app.inCircle(bounds, for: angle, margin: radius * marginRatio / 3)
                let indicatorLayer = AppClockIndicatorLayer()
                indicatorLayer.frame = CGRect(origin: .zero, size: CGSize(width: radius * hourDotRatio, height: radius * hourDotRatio))
                indicatorLayer.cornerRadius = radius * hourDotRatio / 2
                indicatorLayer.position = arcCenter
                indicatorLayer.backgroundColor = clockAttributes.indicatorColor.color(for: traitCollection).cgColor
                layer.addSublayer(indicatorLayer)
            }
        }
        if clockAttributes.isMinuteIndicatorsShown {
            for index in 0..<61 {
                let angle = -.pi * 1/2 + CGFloat(index) / 30 * .pi
                let arcCenter = CGPoint.app.inCircle(bounds, for: angle, margin: radius * marginRatio / 3)
                let indicatorLayer = AppClockIndicatorLayer()
                indicatorLayer.frame = CGRect(origin: .zero, size: CGSize(width: radius * minuteDotRatio, height: radius * minuteDotRatio))
                indicatorLayer.cornerRadius = radius * minuteDotRatio / 2
                indicatorLayer.position = arcCenter
                indicatorLayer.backgroundColor = clockAttributes.indicatorColor.color(for: traitCollection).cgColor
                layer.addSublayer(indicatorLayer)
            }
        }
    }
    func setupUI() {
        addSubview(textsView)
        textsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private class AppClockClassicIndicatorTextsView: UIView {
    var marginRatio: CGFloat
    let hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    let limitedHours = [12, 3, 6, 9]
    let textFontRatio: CGFloat = 1/5
    var hourLabels: [UILabel] = []
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
        hourLabels.forEach {
            $0.removeFromSuperview()
        }
        hourLabels.removeAll()
        for hour in hourNums(for: clockAttributes?.isLimitedHoursShown ?? false) {
            let label = UILabel()
            label.text = "\(hour)"
            addSubview(label)
            hourLabels.append(label)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard clockAttributes != nil else {
            return
        }
        let fontSize = (bounds.app.radius * textFontRatio).rounded()
        let margin = bounds.app.radius * marginRatio
        for (index, textLabel) in hourLabels.enumerated() {
            textLabel.font = QYFont.font(clockAttributes!.fontName.rawValue, fontSize: fontSize)
            textLabel.textColor = clockAttributes?.indicatorColor.color(for: traitCollection)
            textLabel.sizeToFit()
            let angle = hourAngle(for: clockAttributes!.isLimitedHoursShown, index: CGFloat(index))
            textLabel.center = CGPoint.app.inCircle(bounds, for: angle, margin: margin)
        }
    }
    func hourNums(for isLimitedHoursShown: Bool) -> [Int] {
        if isLimitedHoursShown {
            return limitedHours
        }
        return hours
    }
    func hourAngle(for isLimitedHoursShown: Bool,
                   index: CGFloat) -> CGFloat {
        if isLimitedHoursShown {
            return -.pi * 1/2 + index / 2 * .pi
        }
        return -.pi * 1/2 + index / 6 * .pi
    }
}
