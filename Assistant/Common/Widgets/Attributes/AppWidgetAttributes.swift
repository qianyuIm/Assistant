//
//  AppWidgetConfig.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit

struct AppWidgetAttributes: Equatable {
    
    var name: String?
    /// 背景
    var background = BackgroundStyle.color(color: UIColor.orange)
    /// 圆角
    var roundCorners = RoundCorners.all(radius: 10)
    /// 边框
    var border = Border.none
    /// 小组件风格
    var widgetFamily = WidgetFamily.small
    /// 时间显示格式
    var timeDisplayMode = TimeDisplayMode.twelve
    /// 字体和颜色
    var labelStyle = AppWidgetAttributes.LabelStyle()

    static func == (lhs: AppWidgetAttributes, rhs: AppWidgetAttributes) -> Bool {
        return lhs.name == rhs.name && lhs.background == rhs.background && lhs.roundCorners == rhs.roundCorners && lhs.border == rhs.border && lhs.widgetFamily == rhs.widgetFamily && lhs.timeDisplayMode == rhs.timeDisplayMode && lhs.labelStyle == rhs.labelStyle
    }
}

extension AppWidgetAttributes {
    init(with name: String) {
        self.name = name
    }
    init(with labelStyle: AppWidgetAttributes.LabelStyle) {
        self.labelStyle = labelStyle
    }
}
