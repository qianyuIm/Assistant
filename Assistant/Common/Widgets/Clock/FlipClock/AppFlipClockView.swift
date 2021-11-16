//
//  AppFlipClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//  翻页时钟

import UIKit
import Schedule

class AppFlipClockView: UIView {
    
    var attributes: AppWidgetAttributes
    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var hourItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .hour,
                                    attributes: attributes)
        return hour
    }()
    lazy var minuteItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .minute,
                                    attributes: attributes)
        return hour
    }()
    lazy var secondItem: AppFlipClockItem = {
        let hour = AppFlipClockItem(itemType: .second,
                                    attributes: attributes)
        return hour
    }()
    lazy var minuteLabel: UILabel = {
        let hour = UILabel()
        return hour
    }()
    var date: Date? {
        didSet {
            minuteLabel.text = "\(date?.second ?? 0)"
        }
    }
    init(attributes: AppWidgetAttributes) {
        self.attributes = attributes
        super.init(frame: .zero)
        backgroundColor = .orange
        addSubview(minuteLabel)
        minuteLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AppFlipClockView {
    
}
