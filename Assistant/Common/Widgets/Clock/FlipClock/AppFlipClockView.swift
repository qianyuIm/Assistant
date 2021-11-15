//
//  AppFlipClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//  翻页时钟

import UIKit


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
    init(attributes: AppWidgetAttributes) {
        self.attributes = attributes
        super.init(frame: .zero)
        applySubViews()
//        applyBackground()
//        applyFrameStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AppFlipClockView {
    func applySubViews() {
        addSubview(backgroundView)
        addSubview(hourItem)
        addSubview(minuteItem)
        addSubview(secondItem)
        setupConstraints()
    }
    func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hourItem.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
//    func applyBackground() {
//
//    }
//
//    func applyFrameStyle() {
//
//    }
    
    
}
