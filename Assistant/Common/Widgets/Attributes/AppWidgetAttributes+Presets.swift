//
//  AppWidgetAttributes+Presets.swift
//  Assistant
//
//  Created by cyd on 2021/11/22.
//

import UIKit

extension AppWidgetAttributes {
    /// 圆形时钟
    static var analogClock: AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.labelStyle.font = QYFont.fontRegular(10)
        return attributes
    }
    /// 数据流量
    static var flow: AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.background = .color(hexString: "#2E2E2E")
        return attributes
    }
}
