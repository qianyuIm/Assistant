//
//  AppThemeManager.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import UIKit
import RxTheme
import RxCocoa
import RxSwift
import SwiftyUserDefaults
/// 主题配置
let appThemeProvider = AppThemeProvider.service(initial: AppThemeProvider.currentTheme())

private func _value() -> UIStatusBarStyle {
    let value: UIStatusBarStyle = QYConfig.Theme.isDark() ? .lightContent : .darkContent
    return value
}
let globalStatusBarStyle = BehaviorRelay<UIStatusBarStyle>(value: _value())

protocol AppThemeProtocol {
    /// 主色
    var primaryColor: UIColor { get }
    /// tabbar 主题
    var tabbarTheme: TabbarTheme { get }
    /// navigationBar 主题
    var navigationBarTheme: NavigationBarTheme { get }
    /// 背景色
    var backgroundColor: UIColor { get }
    /// 分割线颜色
    var separatorColor: UIColor { get }
    /// statusBar
    var statusBarStyle: UIStatusBarStyle { get }
    /// 文字颜色主题
    var textTheme: TextTheme { get }
    /// 分段控制器主题
    var segmentedTheme: SegmentedTheme { get }
    /// card 主题
    var cardTheme: CardTheme { get }
    init(colorSwatch: AppColorSwatch)
}

struct AppLightTheme: AppThemeProtocol {
    var primaryColor: UIColor
    var tabbarTheme: TabbarTheme
    var navigationBarTheme: NavigationBarTheme
    let backgroundColor = UIColor.app.color(hexString: "#F2F2F7")
    let separatorColor = UIColor.app.color(hexString: "#999999", transparency: 0.5)
    var statusBarStyle: UIStatusBarStyle
    let textTheme = TextTheme(titleColor: UIColor.app.color(hexString: "#3D444B"),
                              subtitleColor: UIColor.app.color(hexString: "#626262"))
    
    var segmentedTheme: SegmentedTheme
    let cardTheme = CardTheme(color: UIColor.white, radius: 6)
    init(colorSwatch: AppColorSwatch) {
        primaryColor = colorSwatch.color
        if #available(iOS 13.0, *) {
            statusBarStyle = .darkContent
        } else {
            statusBarStyle = .default
        }
        tabbarTheme = TabbarTheme(
            textColor: QYColor.black54,
            highlightTextColor: primaryColor,
            iconColor: QYColor.black54,
            highlightIconColor: primaryColor,
            barTintColor: UIColor.white)
        navigationBarTheme = NavigationBarTheme(
            barTintColor: UIColor.white,
            tintColor: QYColor.black54,
            foregroundColor: QYColor.black54,
            barStyle: UIBarStyle.default)
        segmentedTheme = SegmentedTheme(
            titleNormalColor: QYColor.black54,
            titleSelectedColor: primaryColor,
            indicatorColor: primaryColor,
            titleNormalFont: QYFont.fontMedium(13),
            titleSelectedFont: QYFont.fontSemibold(15)
        )
    }
}

struct AppDarkTheme: AppThemeProtocol {
    var primaryColor: UIColor
    var tabbarTheme: TabbarTheme
    var navigationBarTheme: NavigationBarTheme
    let backgroundColor = UIColor.app.color(hexString: "#323232")
    let separatorColor = UIColor.app.color(hexString: "#999999", transparency: 0.5)
    let statusBarStyle: UIStatusBarStyle = .lightContent
    let textTheme = TextTheme(titleColor: UIColor.app.color(hexString: "#FFFFFF"),
                              subtitleColor: UIColor.app.color(hexString: "#E6E6E6"))
    var segmentedTheme: SegmentedTheme
    let cardTheme = CardTheme(color: UIColor.app.color(hexString: "#5A5A5A"), radius: 6)

    init(colorSwatch: AppColorSwatch) {
        primaryColor = colorSwatch.colorDark
        tabbarTheme = TabbarTheme(
            textColor: QYColor.white70,
            highlightTextColor: primaryColor,
            iconColor: QYColor.white70,
            highlightIconColor: primaryColor,
            barTintColor: UIColor.app.color(hexString: "#252528"))
        navigationBarTheme = NavigationBarTheme(
            barTintColor: UIColor.app.color(hexString: "#252528"),
            tintColor: QYColor.white70,
            foregroundColor: QYColor.white70,
            barStyle: UIBarStyle.black
        )
        segmentedTheme = SegmentedTheme(
            titleNormalColor: QYColor.white70,
            titleSelectedColor: primaryColor,
            indicatorColor: primaryColor,
            titleNormalFont: QYFont.fontMedium(13),
            titleSelectedFont: QYFont.fontSemibold(15)
        )
    }
}

enum AppColorSwatch: Int {
    case netease, didi, weChat, fish, quark

    static let allValues = [netease, didi, weChat, fish, quark]

    var color: UIColor {
        switch self {
        case .netease: return UIColor.app.color(hexString: "#F83245")
        case .didi: return UIColor.app.color(hexString: "#FF7B24")
        case .weChat: return UIColor.app.color(hexString: "#03dc6a")
        case .fish: return UIColor.app.color(hexString: "#dda600")
        case .quark: return UIColor.app.color(hexString: "#9565b1")
        }
    }

    var colorDark: UIColor {
        switch self {
        case .netease: return UIColor.app.color(hexString: "#bd0618")
        case .didi: return UIColor.app.color(hexString: "#EC5D00")
        case .weChat: return UIColor.app.color(hexString: "#03a04d")
        case .fish: return UIColor.app.color(hexString: "#a17900")
        case .quark: return UIColor.app.color(hexString: "#6e4486")
        }
    }

    var title: String {
        switch self {
        case .netease: return "网易红"
        case .didi: return "滴滴橙"
        case .weChat: return "微信绿"
        case .fish: return "闲鱼黄"
        case .quark: return "夸克紫"
        }
    }
}
enum AppThemeProvider: ThemeProvider {
    case light(colorSwatch: AppColorSwatch)
    case dark(colorSwatch: AppColorSwatch)
    var associatedObject: AppThemeProtocol {
        switch self {
        case .light(let colorSwatch): return AppLightTheme(colorSwatch: colorSwatch)
        case .dark(let colorSwatch): return AppDarkTheme(colorSwatch: colorSwatch)
        }
    }
    var isDark: Bool {
        switch self {
        case .dark: return true
        default: return false
        }
    }
    private func switchInferred() {
        QYConfig.Theme.displayMode = .inferred
        /// 当前系统主题
        var systemMode = false
        if let userInterfaceStyle = AppDelegate.shared.window?.traitCollection.userInterfaceStyle {
            systemMode = userInterfaceStyle == .dark
        }
        if systemMode != isDark {
            var themeProvider: AppThemeProvider
            switch self {
            case .light(let colorSwatch):
                themeProvider = AppThemeProvider.dark(colorSwatch: colorSwatch)
            case .dark(let colorSwatch):
                themeProvider = AppThemeProvider.light(colorSwatch: colorSwatch)
            }
            themeProvider.save()
            appThemeProvider.switch(themeProvider)
        } else {
            QYLogger.debug("不做任何操作")
        }
    }
    private func switchLight() {
        switch self {
        case .dark(let colorSwatch):
            let themeProvider = AppThemeProvider.light(colorSwatch: colorSwatch)
            themeProvider.save()
            QYConfig.Theme.displayMode = .light
            appThemeProvider.switch(themeProvider)
        default: break
        }
    }
    private func switchDark() {
        switch self {
        case .light(let colorSwatch):
            let themeProvider = AppThemeProvider.dark(colorSwatch: colorSwatch)
            themeProvider.save()
            QYConfig.Theme.displayMode = .dark
            appThemeProvider.switch(themeProvider)
        default: break
        }
    }
    func switchWithColor(_ colorSwatch: AppColorSwatch) {
        var themeProvider: AppThemeProvider
        switch self {
        case .light: themeProvider = AppThemeProvider.light(colorSwatch: colorSwatch)
        case .dark: themeProvider = AppThemeProvider.dark(colorSwatch: colorSwatch)
        }
        themeProvider.save()
        appThemeProvider.switch(themeProvider)
    }
    func switchWithDisplayMode(_ displayMode: QYConfig.Theme.DisplayMode) {
        switch displayMode {
        case .inferred:
            switchInferred()
        case .light:
            switchLight()
        case .dark:
            switchDark()
        }
    }
}
extension AppThemeProvider {
    static func currentTheme() -> AppThemeProvider {
        let themeKey = QYConfig.Theme.themeSwatchIndex
        let colorSwatch = AppColorSwatch(rawValue: themeKey) ?? AppColorSwatch.netease
        let theme = QYConfig.Theme.isDark() ? AppThemeProvider.dark(colorSwatch: colorSwatch) : AppThemeProvider.light(colorSwatch: colorSwatch)
        theme.save()
        return theme
    }

    func save() {
        switch self {
        case .light(let colorSwatch): QYConfig.Theme.themeSwatchIndex = colorSwatch.rawValue
        case .dark(let colorSwatch): QYConfig.Theme.themeSwatchIndex = colorSwatch.rawValue
        }
    }
}
