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
    case universal_needlogin
    /// iosApp://login?
    case login
    /// wifi 传书
    case wifiUploader
    /// 设置页面
    case setting
}

//extension QYBaseController: AppRouterable {}

extension AppRouterType: AppRouterTypeable {
    var pattern: String {
        switch self {
        case .universal:
            return QYConfig.scheme + "universal"
        case .universal_needlogin:
            return QYConfig.scheme + "universalNeedLogin"
        case .login:
            return QYConfig.scheme + "login"
        case .wifiUploader:
            return QYConfig.scheme + "wifiUploader"
        case .setting:
            return QYConfig.scheme + "user/setting"
        }
    }
    func controller(url: URLConvertible, values: [String : Any], context: AppRouterContext?) -> AppRouterable? {
        switch self {
        case .setting:
            return AppSettingController(viewModel: AppSettingViewModel())
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
