//
//  SmallWidgetAnalogClockCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class SmallWidgetAnalogClockCell: UICollectionViewCell {
    var attributes = AppWidgetAttributes()
    lazy var clockContentView: AppWidgetBackgroundView = {
        let view = AppWidgetBackgroundView()
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = attributes.roundCorners.cornerValues
        view.app.addRoundCorners(corners, radius: cornerRadius)
        view.style = .init(background: attributes.background)
        return view
    }()
    lazy var analogClockView: AppAnalogClockView = {
        let view = AppAnalogClockView()
        view.attributes = attributes
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
//        analogClockView.attributes = attributes
//        flipClockView.dateSource = Date()
        titleLabel.text = attributes.name
        if self.attributes.clockStyle.size != attributes.clockStyle.size {
            analogClockView.snp.updateConstraints { make in
                make.size.equalTo(attributes.clockStyle.size)
            }
        }
        if self.attributes.background != attributes.background {
            var cornerRadius: CGFloat = 0
            var corners: UIRectCorner = []
            (corners, cornerRadius) = attributes.roundCorners.cornerValues
            clockContentView.app.addRoundCorners(corners, radius: cornerRadius)
            clockContentView.style = .init(background: attributes.background)
        }
        self.attributes = attributes
    }
}

extension SmallWidgetAnalogClockCell {
    func setupUI() {
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
            make.size.equalTo(attributes.clockStyle.size)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(analogClockView.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-6)
        }
    }
}
