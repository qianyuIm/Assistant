//
//  AppWidgetShared+Reload.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//

import Foundation
import WidgetKit

extension NotificationCenter {
    enum Theme: AppNotificationable {
        enum DefaultKeys: String {
            case WidgetThemeChangeNotification
        }
    }
}
extension AppWidgetShared {
    class func reloadTheme() {
        NotificationCenter.Theme.post(.WidgetThemeChangeNotification, object: nil, userInfo: nil)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
