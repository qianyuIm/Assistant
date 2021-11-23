//
//  AppHomeUserWidgetView.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit

class AppHomeUserWidgetView: UIView, AppNibLoadableView {
    @IBOutlet weak var iconContentView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionSender: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        actionSender.setTitle("", for: .normal)
        titleLabel.font = QYFont.fontRegular(13)
        app.addRoundCorners(.allCorners, radius: 14)
        let image = appIconFontIcons.icon_user_fill.image(size: 14)
        icon.image = image?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = R.string.localizable.barWidgetRightTitle.key.app.localized()
        iconContentView.app.addRoundCorners(.allCorners, radius: 10)
        bindTheme()
    }
    func bindTheme() {
        titleLabel.theme.textColor = appThemeProvider.attribute({ $0.textTheme.titleColor
        })
        theme.backgroundColor = appThemeProvider.attribute {
            $0.backgroundColor
        }
        iconContentView.theme.backgroundColor = appThemeProvider.attribute {
            $0.cardTheme.color
        }
    }
    @IBAction func tapAction(_ sender: UIButton) {
        AppRouter.shared.open(AppRouterType.myWidgets.pattern, context: nil)
    }
}
