//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit

class AppMoreController: AppBaseVMController {
    lazy var settingItem: UIBarButtonItem = {
        let image = appIconFontIcons.icon_settings.image(size: 24)
        let item = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(handleSettingAction(_:event:)))
        return item
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationItem.rightBarButtonItem = settingItem
    }
    override func setupLanguage() {
        super.setupLanguage()
    }
    @objc func handleSettingAction(_ sender: AnyObject, event: UIEvent) {
        AppRouter.shared.open(AppRouterType.setting.pattern, context: nil)
    }
}
