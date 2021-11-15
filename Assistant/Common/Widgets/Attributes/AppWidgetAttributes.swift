//
//  AppWidgetConfig.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit

struct AppWidgetAttributes {
    var name: String? = "我是小组件"
    /// 背景
    var background = BackgroundStyle.clear
    /// 圆角
    var roundCorners = RoundCorners.all(radius: 10)
    /// 边框
    var border = Border.none
    /// 小组件风格
    var widgetFamily = WidgetFamily.small
    /// 时间显示格式
    var timeFormat = TimeFormat.twelve
    /// 字体和颜色
    var labelStyle = LabelStyle()
    init() {
    
    }
}
