//
//  AppSettingCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit
import RxTheme

class AppSettingCell: UICollectionViewCell, AppNibLoadableView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    var item: AppSettingCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.theme.textColor = appThemeProvider.attribute({ $0.textTheme.titleColor
        })
        arrowImageView.theme.tintColor = appThemeProvider.attribute({ $0.textTheme.subtitleColor
        })
        iconImageView.theme.tintColor = appThemeProvider.attribute({ $0.primaryColor
        })
    }
    func config(_ item: AppSettingCellViewModel) {
        titleLabel.text = item.title
        iconImageView.image = item.iconImage?.withRenderingMode(.alwaysTemplate)
        let arrowImage = item.arrowImage ?? appIconFontIcons.icon_arrow_right.image(size: 24)
        arrowImageView.image = arrowImage?.withRenderingMode(.alwaysTemplate)
    }
}
