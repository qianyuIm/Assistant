//
//  SmallWidgetAnalogClockCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class SmallWidgetFlowCell: UICollectionViewCell {
    lazy var flowView: AppFlowView = {
        let view = AppFlowView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = QYFont.fontMedium(13)
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(with attributes: AppWidgetAttributes) {
//        flipClockView.attributes = attributes
//        flipClockView.dateSource = Date()
        titleLabel.text = attributes.name
    }
}

extension SmallWidgetFlowCell {
    func setupUI() {
        contentView.addSubview(flowView)
        contentView.addSubview(titleLabel)
        setupConstraints()
        titleLabel.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
    }
    func setupConstraints() {
        flowView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(QYInch.Widget.smallSize)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(flowView.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-6)
        }
    }
}
