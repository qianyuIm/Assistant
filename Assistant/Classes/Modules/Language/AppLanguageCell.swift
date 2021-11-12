//
//  AppLanguageCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/11.
//

import UIKit
import M13Checkbox

class AppLanguageCell: UICollectionViewCell ,AppNibLoadableView{

    @IBOutlet weak var launguageTitleLabel: UILabel!
    
    @IBOutlet weak var checkBoxView: M13Checkbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBoxView.isEnabled = false
        appThemeProvider.typeStream.subscribe (onNext:{[weak self] themeType in
            self?.checkBoxView.tintColor = themeType.associatedObject.primaryColor
            self?.checkBoxView.secondaryTintColor = themeType.associatedObject.textTheme.subtitleColor
            self?.launguageTitleLabel.textColor = themeType.associatedObject.textTheme.titleColor
        }).disposed(by: rx.disposeBag)
        
    }
    func config(_ item: AppLanguageItem) {
        launguageTitleLabel.text = item.disPlayName
        checkBoxView.isSelected = item.isSelected
        if (item.isSelected) {
            checkBoxView.setCheckState(.checked, animated: true)
        } else {
            checkBoxView.setCheckState(.unchecked, animated: false)
        }
    }

}
