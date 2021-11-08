//
//  AppLanguageController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit

class AppLanguageController: AppBaseVMController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        navigationItem.title = R.string.localizable.languageNavigationTitle.key.app.localized()
    }
}
