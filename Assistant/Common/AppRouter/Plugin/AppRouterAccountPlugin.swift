//
//  AppRouterAccountPlugin.swift
//  ios_app
//
//  Created by cyd on 2021/10/20.
//

import Foundation
/// 授权插件 是否登录
class AppRouterAccountPlugin: AppRouterPlugin<AppRouterType> {
    override func prepare(open type: AppRouterType, completion: @escaping (Bool) -> Void) {
        guard type == .universalNeedlogin else {
            QYLogger.debug("直接通过")
            completion(true)
            return
        }
        guard (AppDelegate.shared.window?.rootViewController) != nil else {
            completion(false)
            return
        }
        QYLogger.debug("需要登录才行")
        let context = AppRouterContext()
        context.completionHandler = { result in
            guard let result = result else {
                completion(false)
                return
            }
            if let haveLogin = result[kAppRouterContextLoginResultKey] as? Bool {
                completion(haveLogin)
            }
        }
        AppRouter.shared.open(AppRouterType.login.pattern, context: context)
    }
    
}
