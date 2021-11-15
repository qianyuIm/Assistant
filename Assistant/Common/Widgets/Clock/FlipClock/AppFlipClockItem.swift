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
    
    private lazy var leftLabel: AppFlipClockLabel = {
        let label = AppFlipClockLabel(attributes: attributes)
        return label
    }()
    private lazy var rightLabel: AppFlipClockLabel = {
        let label = AppFlipClockLabel(attributes: attributes)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.red
        return line
    }()
    
    var itemType: ItemType
    var attributes: AppWidgetAttributes
    init(itemType: ItemType,
         attributes: AppWidgetAttributes) {
        self.itemType = itemType
        self.attributes = attributes
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppFlipClockItem {
    func configUI() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(lineView)
        setupConstraints()
    }
    func setupConstraints() {
        leftLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        rightLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(leftLabel.snp.right).offset(4)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(5)
        }
    }
}
