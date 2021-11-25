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
        attributes.widgetType = .flipClock
        attributes.widgetFamily = widgetFamily
        return attributes
    }
    /// 圆形时钟
    static func analogClock(_ widgetFamily: AppWidgetAttributes.WidgetFamily) -> AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.widgetType = .analogClock
        attributes.widgetFamily = widgetFamily
        return attributes
    }
    /// 数据流量
    static func flow(_ widgetFamily: AppWidgetAttributes.WidgetFamily) -> AppWidgetAttributes {
        var attributes = AppWidgetAttributes()
        attributes.widgetType = .flow
        attributes.widgetFamily = widgetFamily
        attributes.background = .color(color: .init(light: "#2E2E2E", dark: "#ffffff"))
        return attributes
    }
}
