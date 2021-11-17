//
//  MediumWidgetFlipClockCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/16.
//

import UIKit

class LargeWidgetFlipClockCell: UICollectionViewCell {
    lazy var flipClockView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
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
//        titleLabel.text = attributes.name
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = attributes.roundCorners.cornerValues
        self.flipClockView.app.addRoundCorners(corners, radius: cornerRadius)
    }
}
extension LargeWidgetFlipClockCell {
    func setupUI() {
        contentView.addSubview(flipClockView)
        contentView.addSubview(titleLabel)
        setupConstraints()
        titleLabel.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
    }
    func setupConstraints() {
        flipClockView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(QYInch.Widget.largeAspectRatioSize.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(flipClockView.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-6)
        }
    }
}
