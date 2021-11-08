//
//  AppUserWidgetView.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit


class AppUserWidgetView: UIView,AppNibLoadableView {

    @IBOutlet weak var iconContentView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = QYFont.fontRegular(13)
        backgroundColor = .red
        app.addRoundCorners(.allCorners, radius: 14)
        let image = appIconFontIcons.icon_user_fill.image(size: 14)
        icon.image = image
        titleLabel.text = R.string.localizable.barWidgetRightTitle.key.app.localized()
        iconContentView.app.addRoundCorners(.allCorners, radius: 10)
        bindTheme()
    }
    
    func bindTheme() {
        titleLabel.theme.textColor = appThemeProvider.attribute({ $0.textTheme.titleColor
        })
        
    }
}
