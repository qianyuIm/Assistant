//
//  AppFlipClockItem.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit

class AppFlipClockItem: UIView {
    enum ItemType {
        case hour
        case minute
        case second
    }
    /// 最新左边的时间
    private lazy var lastLeftTime: Int = 0
    /// 最新右边的时间
    private lazy var lastRightTime: Int = 0
    private lazy var leftLabel: AppFlipClockLabel = {
        let label = AppFlipClockLabel()
        return label
    }()
    private lazy var rightLabel: AppFlipClockLabel = {
        let label = AppFlipClockLabel()
        return label
    }()
    private lazy var lineView: UIView = {
        let line = UIView()
        return line
    }()
    var itemType: ItemType
    private var _lineViewHeight: CGFloat = 2
    private var lineViewHeight: CGFloat = 2 {
        didSet {
            if _lineViewHeight != lineViewHeight {
                setNeedsLayout()
            }
            _lineViewHeight = lineViewHeight
        }
    }
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            backgroundColor = attributes.labelStyle.backgroundColor.color(for: traitCollection, mode: attributes.displayMode)
            leftLabel.attributes = attributes
            rightLabel.attributes = attributes
            lineView.backgroundColor = attributes.labelStyle.backgroundColor.color(for: traitCollection, mode: attributes.displayMode)
            switch attributes.widgetFamily {
            case .small:
                lineViewHeight = 2
            case .medium:
                lineViewHeight = 3
            case .large:
                lineViewHeight = 4
            }
        }
    }
    var dateSource: Int? {
        didSet {
            configLeftTimeLabel(dateSource! / 10)
            configRightTimeLabel(dateSource! % 10)
        }
    }
    init(itemType: ItemType) {
        self.itemType = itemType
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelW = (bounds.size.width / 2).app.flat - 1
        let labelH = bounds.size.height
        let left: CGFloat = 0.5
        leftLabel.frame = CGRect(x: left.app.flat, y: 0, width: labelW, height: labelH)
        rightLabel.frame = CGRect(x: labelW + 1, y: 0, width: labelW, height: labelH)
        lineView.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: lineViewHeight)
        layer.cornerRadius = bounds.size.height / 10
        layer.masksToBounds = true
    }
}
private extension AppFlipClockItem {
    func configLeftTimeLabel(_ time: Int) {
        if lastLeftTime == time && lastLeftTime != -1 {
            return
        }
        lastLeftTime = time
        var current: Int = 0
        switch itemType {
        case .hour:
            current = time == 0 ? 2 : time - 1
        case .minute:
            current = time == 0 ? 5 : time - 1
        case .second:
            current = time == 0 ? 5 : time - 1
        }
        leftLabel.update(current, next: time)
    }
    func configRightTimeLabel(_ time: Int) {
        if lastRightTime == time && lastRightTime != -1 {
            return
        }
        lastRightTime = time
        var current: Int = 0
        switch itemType {
        case .hour:
            current = time == 0 ? 4 : time - 1
        case .minute:
            current = time == 0 ? 9 : time - 1
        case .second:
            current = time == 0 ? 9 : time - 1
        }
        rightLabel.update(current, next: time)
    }
}
extension AppFlipClockItem {
    func setupUI() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(lineView)
        lastLeftTime = -1
        lastRightTime = -1
    }
}
