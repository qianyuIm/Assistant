//
//  AppFlipClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//  翻页时钟

import UIKit
import Schedule

class AppFlipClockView: UIView {
    lazy var backgroundView: AppWidgetBackgroundView = {
        let view = AppWidgetBackgroundView()
        return view
    }()
    lazy var hourItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .hour)
        return hour
    }()
    lazy var minuteItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .minute)
        return hour
    }()
    lazy var secondItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .second)
        return hour
    }()

    var dateSource: Date = Date() {
        didSet {
            var houe = dateSource.hour
            let minute = dateSource.minute
            let second = dateSource.second
            if (_timeDisplayMode == .twelve || _timeDisplayMode == .twelveMissSecond) && houe > 12 {
                houe -= 12
            }
            hourItem.dateSource = houe
            minuteItem.dateSource = minute
            secondItem.dateSource = second
        }
    }
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            var cornerRadius: CGFloat = 0
            var corners: UIRectCorner = []
            (corners, cornerRadius) = attributes.roundCorners.cornerValues
            self.app.addRoundCorners(corners, radius: cornerRadius)
            backgroundView.style = .init(background: attributes.background)
            timeDisplayMode = attributes.timeDisplayMode
            hourItem.attributes = attributes
            minuteItem.attributes = attributes
            secondItem.attributes = attributes
        }
    }
    private var _timeDisplayMode: AppWidgetAttributes.TimeDisplayMode = .twelve
    private var timeDisplayMode: AppWidgetAttributes.TimeDisplayMode = .twelve {
        didSet {
            if _timeDisplayMode != timeDisplayMode {
                setNeedsLayout()
            }
            _timeDisplayMode = timeDisplayMode
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
        var margin: CGFloat = (0.06 * bounds.size.width).app.flat
        var itemW = ((bounds.size.width - 4 * margin) / 3).app.flat
        backgroundView.frame = bounds
        switch _timeDisplayMode {
        case .twelve, .twentyFour:
            break
        case .twelveMissSecond, .twentyFourMissSecond:
            margin = (0.1 * bounds.size.width).app.flat
            itemW = ((bounds.size.width - 3 * margin) / 2).app.flat
        }
        let itemY: CGFloat = (bounds.size.height - itemW) / 2
        hourItem.frame = CGRect(x: margin, y: itemY, width: itemW, height: itemW)
        minuteItem.frame = CGRect(x: hourItem.frame.maxX + margin, y: itemY, width: itemW, height: itemW)
        secondItem.frame = CGRect(x: minuteItem.frame.maxX + margin, y: itemY, width: itemW, height: itemW)
    }
}
extension AppFlipClockView {
    func setupUI() {
        addSubview(backgroundView)
        addSubview(hourItem)
        addSubview(minuteItem)
        addSubview(secondItem)
    }
}
