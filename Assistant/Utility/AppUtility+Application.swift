//
//  AppUtility+Application.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//

import UIKit
extension AppUtility {
    /// 打开设置页面
    class func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
