//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import SnapKit
import Localize_Swift

class AppWidgetsController: AppBaseVMController {
    lazy var leftItem: UIBarButtonItem = {
        let titleLabel = UILabel()
        titleLabel.text = R.string.localizable.barWidgetLeftTitle.key.localized()
        titleLabel.font = QYFont.fontMedium(26)
        let item = UIBarButtonItem(customView: titleLabel)
        return item
    }()
    lazy var rightItem: UIBarButtonItem = {
        let userView = R.nib.appUserWidgetView.firstView(owner: nil, options: nil)!
        let item = UIBarButtonItem(customView: userView)
        return item
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func setupUI() {
        super.setupUI()
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
}
