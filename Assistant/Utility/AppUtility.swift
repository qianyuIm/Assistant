//
//  AppUtility.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit

class AppUtility {
    /// 打开设置页面
    class func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    class func copy(with value: String, complete: (() -> Void)? = nil) {
        UIPasteboard.general.string = value
        complete?()
    }
}
