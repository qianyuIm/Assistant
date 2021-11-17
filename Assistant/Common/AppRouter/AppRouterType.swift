//
//  AppLinks.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import URLNavigator
import UIKit
import CoreMedia

/// 根据链接参数来指定页面
/// iosApp://universal?openPage=web&needlogin=1&webUrl=https://www.baidu.com
fileprivate enum AppRouterOpenPage: String {
    case unknown
    case widget
    case icons
    case wallpaper
    case more
    case web
}

enum AppRouterType {
    /// iosApp://universal?
    case universal
    /// iosApp://universalNeedLogin?
    case universalNeedlogin
    /// iosApp://login?
    case login
    /// wifi 传书
    case wifiUploader
    /// 我的组件
    case myWidgets
    /// 设置页面
    case setting
    /// 透明
    case transparent
    /// 常见问题
    case question
    /// 主题设置
    case themeSetting
    /// 语言设置
    case languageSetting
    /// 权限
    case permission
    /// 关于我们
    case about
    /// 小组件限制
    case limit
    
}

private let kConfigPath = "config/"
extension AppRouterType: AppRouterTypeable {
    var pattern: String {
        switch self {
        case .universal:
            return QYConfig.scheme + "universal"
        case .universalNeedlogin:
            return QYConfig.scheme + "universalNeedLogin"
        case .login:
            return QYConfig.scheme + "login"
        case .wifiUploader:
            return QYConfig.scheme + "wifiUploader"
        case .myWidgets:
            return QYConfig.scheme + "myWidgets"
        case .setting:
            return QYConfig.scheme + "user/setting"
        case .transparent:
            return QYConfig.scheme + kConfigPath + "transparent"
        case .question:
            return QYConfig.scheme + kConfigPath + "question"
        case .themeSetting:
            return QYConfig.scheme + kConfigPath + "theme"
        case .languageSetting:
            return QYConfig.scheme + kConfigPath + "language"
        case .permission:
            return QYConfig.scheme + kConfigPath + "permission"
        case .about:
            return QYConfig.scheme + kConfigPath + "about"
        case .limit:
            return QYConfig.scheme + kConfigPath + "limit"
        }
    }
    func controller(url: URLConvertible, values: [String : Any], context: AppRouterContext?) -> AppRouterable? {
        switch self {
        case .myWidgets:
            return MyWidgetsController(viewModel: MyWidgetsViewModel(),
                                        context: context)
        case .setting:
            return AppSettingController(viewModel: AppSettingViewModel(),
                                        context: context)
        case .transparent:
            return AppTransparentController(viewModel: AppTransparentViewModel(),
                                            context: context)
        case .themeSetting:
            return AppThemeController(viewModel: AppThemeViewModel(), context: context)
        case .languageSetting:
            return AppLanguageController(viewModel: AppLanguageViewModel(), context: context)
        case .limit:
            return AppLimitController()
        default:
            return nil
        }
    }
    
    func handle(url: URLConvertible, values: [String : Any], context: AppRouterContext?) {
        let parameters = url.queryParameters
        guard let openPage = parameters[QYConfig.Router.pageKey] else { return }
        let page = AppRouterOpenPage(rawValue: openPage) ?? .unknown
        _handle(page: page, parameters)
    }
    
}

private extension AppRouterType {
    ///
    func _handle(page: AppRouterOpenPage,_ parameters: [String: String]) {
        switch page {
        case .widget:
            AppUtility.toRootController(true, .widget)
            break
        case .icons:
            AppUtility.toRootController(true, .icons)
            break
        case .wallpaper:
            AppUtility.toRootController(true, .wallpaper)
            break
        case .more:
            AppUtility.toRootController(true, .more)
            break
        
        case .web:
            guard let webUrl = parameters[QYConfig.Router.webUrlKey] else {
                return
            }
            let webVC = AppBaseWebController()
            webVC.webUrl = webUrl
            webVC.routerOpen(with: nil)
            break
        default:
            break
        }
    }
}
