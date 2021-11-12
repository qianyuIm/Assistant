//
//  AppThemeCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/12.
//

import UIKit
import M13Checkbox

class AppThemeCell: UICollectionViewCell,AppNibLoadableView {

    @IBOutlet weak var themView: UIView!
    
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var checkBoxView: M13Checkbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBoxView.isEnabled = false
        appThemeProvider.typeStream.subscribe (onNext:{[weak self] themeType in
            self?.checkBoxView.tintColor = themeType.associatedObject.textTheme.titleColor
            self?.checkBoxView.secondaryTintColor = themeType.associatedObject.textTheme.subtitleColor
            self?.themeTitleLabel.textColor = themeType.associatedObject.textTheme.titleColor
        }).disposed(by: rx.disposeBag)
        themView.app.addRoundCorners(.allCorners, radius: 4)
    }
    func config(_ item: AppThemeItem) {
        if (QYConfig.Theme.isDark()) {
            themView.backgroundColor = item.colorSwatch.colorDark
        } else {
            themView.backgroundColor = item.colorSwatch.color
        }
        themeTitleLabel.text = item.colorSwatch.title
        if (item.isSelected) {
            checkBoxView.setCheckState(.checked, animated: true)
        } else {
            checkBoxView.setCheckState(.unchecked, animated: false)
        }
    }
}
