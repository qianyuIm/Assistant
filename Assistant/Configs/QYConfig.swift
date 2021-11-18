//
//  QYConfig.swift
//  ios_app
//
//  Created by cyd on 2021/10/14.
//

import UIKit
import SwiftyUserDefaults
import Localize_Swift
import SnapKit

struct QYConfig {
    /// 启动页面展示 前后台时间间隔  默认: 60 * 3 s
    static let showEnterForegroundAdTimeInterval: Double = 10 * 3
    static let channel = "pgy"
    static let alias = "assistant"
    static let appDisplayName = R.string.infoPlist.cfBundleDisplayName()
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    static let scheme = "assistant://"
    static let userAgent = "assistant/\(appVersion)"

    struct Value {
        /// -1
        static let undefinedValue: CGFloat = -1
    }
    struct Notification {
        /// 只有 category 匹配才会使用 NotificationContentExtension
        static let contentExtensionCategory = "contentExtensionCategory"
        static let serviceExtensionCategory = "serviceExtensionCategory"
        static let notInterestedActionIdentifier = "notInterestedAction"
        static let openActionIdentifier = "openAction"
        static let mediaType = "mediaType"
        static let mediaUrl = "mediaUrl"
        static let mediaHeight = "mediaHeight"
        static let amount = "amount"
        /// 原生目标路径 与 targetUrl 互斥
        static let targetPage = "targetPage"
        /// H5目标路径 与 targetPage 互斥
        static let targetUrl = "targetUrl"
    }
    struct Theme {
        enum DisplayMode: String, DefaultsSerializable {
            case inferred
            case light
            case dark
        }
        static let supportSwatchs = AppColorSwatch.allValues

        static var themeSwatchIndex: Int {
            get {
                return Defaults.themeSwatchIndexKey
            }
            set {
                Defaults.themeSwatchIndexKey = newValue
            }
        }
        static var displayMode: DisplayMode {
            get {
                return Defaults.themeDisplayModeKey
            }
            set {
                Defaults.themeDisplayModeKey = newValue
            }
        }
        /// 是否为暗色 单存
        static func isDark() -> Bool {
            var isDark = false
            /// 当前系统主题
            if let userInterfaceStyle = AppDelegate.shared.window?.traitCollection.userInterfaceStyle {
                isDark = userInterfaceStyle == .dark
            }
            isDark = (QYConfig.Theme.displayMode == .inferred) ? isDark : (QYConfig.Theme.displayMode == .dark)
            return isDark
        }
    }
    struct Language {
        static let auto = "auto"
        static var autoSystem: Bool {
            get {
                return Defaults.languageAutoSystem
            }
            set {
                Defaults.languageAutoSystem = newValue
            }
        }
        static func support() -> [String] {
            return Localize.availableLanguages(true)
        }
        static func current() -> String {
            return autoSystem ? auto : Localize.currentLanguage()
        }
        static func displayNameForLanguage(_ language: String) -> String {
            return Localize.displayNameForLanguage(language)
        }
        static func setCurrentLanguage(_ language: String) {
            Localize.setCurrentLanguage(language)
        }
    }
}
