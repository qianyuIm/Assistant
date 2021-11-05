//
//  AppDelegate+Internal.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import RxTheme

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    /// 内部配置
    func _configurationInterna(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        _setupShortcutItems()
        _setupRouter()
        _setupReachability()
        _configNavigationBar()
        _initializeRoot()
        _displayAd()
        _alertLaunchPrivacy()
    }
    /// 更新 Shortcut
    func updateShortcutItems() {
//        _setupShortcutItems()
    }
    /// 3D touch
    @discardableResult
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        return true
    }
    
    
}

private extension AppDelegate {
    func _setupShortcutItems() {
//        var myShortcutItems: [UIApplicationShortcutItem] = []
//        for item in [AppShortcutItem.play, AppShortcutItem.daily, AppShortcutItem.read,AppShortcutItem.uploader] {
//            myShortcutItems.append(UIApplicationShortcutItem(type: item.type, localizedTitle: item.localizedTitle, localizedSubtitle: item.localizedSubtitle, icon: item.icon))
//        }
//        UIApplication.shared.shortcutItems = myShortcutItems
        
    }
    /// 路由
    func _setupRouter() {
//        AppRouter.shared.initRouter()
    }
    /// 网络监控
    func _setupReachability() {
        QYReachability.shared.startNotifier()
    }
    /// 导航
    func _configNavigationBar() {
       
        let navigationBar = UINavigationBar.appearance()
        navigationBar.shadowImage = UIImage()

        navigationBar.theme.tintColor = appThemeProvider.attribute{ $0.navigationBarTheme.tintColor }
        navigationBar.theme.barTintColor = appThemeProvider.attribute { $0.navigationBarTheme.barTintColor }
//        navigationBar.theme.barStyle = appThemeProvider.attribute { $0.navigationBarTheme.barStyle
//        }
        navigationBar.theme.titleTextAttributes = appThemeProvider.attribute { [NSAttributedString.Key.foregroundColor: $0.navigationBarTheme.foregroundColor,NSAttributedString.Key.font: QYFont.fontSemibold(18)] }
        
        
    }
    /// root
    func _initializeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let tabbar = AppTabBarController()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    /// launch
    func _displayAd() {
        launchAd = AppLaunchAd()
        launchAd?.start()
    }
    
    /// 启动隐私协议
    func _alertLaunchPrivacy() {
        QYAlert.alertPrivacyPolicy()
    }
}
