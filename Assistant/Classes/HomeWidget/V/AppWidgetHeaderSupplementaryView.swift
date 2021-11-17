//
//  AppWidgetHeaderSupplementaryView.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit
import RxTheme

class AppWidgetHeaderSupplementaryView: UICollectionReusableView, AppNibLoadableView{
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actionSender: UIButton!
    
    var supplementary: AppWidgetSupplementaryModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actionSender.titleLabel?.font = QYFont.fontRegular(13)
        actionSender.setTitle(R.string.widgets.sectionMore
                                .key.app.widgetsLocalized(), for: .normal)
        titleLabel.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.titleColor
        })
        actionSender.theme.titleColor(from: appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        }), for: .normal)

    }
    
    func config(supplementary: AppWidgetSupplementaryModel) {
        iconImageView.image = supplementary.icon
        titleLabel.text = supplementary.title
        actionSender.isHidden = !supplementary.router
    }
    
    @IBAction func senderAction(_ sender: UIButton) {
        QYLogger.debug("点击查看更多")
        if let routerPattern = self.supplementary?.routerPattern {
            AppRouter.shared.open(routerPattern, context: nil)
        }
    }
    
}
