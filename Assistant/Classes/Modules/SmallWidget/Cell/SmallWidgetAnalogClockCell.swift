//
//  SmallWidgetAnalogClockCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class SmallWidgetAnalogClockCell: UICollectionViewCell {
    lazy var clockContentView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var analogClockView: AppAnalogClockView = {
        let view = AppAnalogClockView()
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

extension SmallWidgetAnalogClockCell {
    func setupUI() {
        contentView.backgroundColor = .systemPink
        contentView.addSubview(clockContentView)
        clockContentView.addSubview(analogClockView)
        contentView.addSubview(titleLabel)
        setupConstraints()
        titleLabel.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
    }
    func setupConstraints() {
        clockContentView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(QYInch.Widget.smallSize)
        }
        analogClockView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(analogClockView.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-6)
        }
    }
}
