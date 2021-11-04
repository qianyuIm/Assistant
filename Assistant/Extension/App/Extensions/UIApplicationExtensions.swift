//
//  UIApplicationExtensions.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit

extension AppExtensionWrapper where Base == UIApplication {
    var keyWindow: UIWindow? {
        self.base.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }.first?.windows
            .filter { $0.isKeyWindow }.first
    }
}
