//
//  AppWidgetAttributes+Presets.swift
//  Assistant
//
//  Created by cyd on 2021/11/22.
//

import UIKit

extension AppWidgetAttributes {
    /// 翻页时钟
    static func flipClock(_ widgetFamily: AppWidgetAttributes.WidgetFamily) -> AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.widgetFamily = widgetFamily
        attributes.labelStyle.font = QYFont.fontRegular(10)
        return attributes
    }
    /// 圆形时钟
    static func analogClock(_ widgetFamily: AppWidgetAttributes.WidgetFamily) -> AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.widgetFamily = widgetFamily
        attributes.labelStyle.font = QYFont.fontRegular(10)
        return attributes
    }
    /// 数据流量
    static func flow(_ widgetFamily: AppWidgetAttributes.WidgetFamily) -> AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.widgetFamily = widgetFamily
        attributes.background = .color(hexString: "#5A5A5A")
        return attributes
    }
}
