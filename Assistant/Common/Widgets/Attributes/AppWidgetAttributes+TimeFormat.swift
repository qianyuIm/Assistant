//
//  AppWidgetAttributes+TimeFormat.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation

extension AppWidgetAttributes {
    enum TimeDisplayMode {
        /// 12小时
        case twelve
        /// 24 小时
        case twentyFour
        /// 12小时 不展示 秒
        case twelveMissSecond
        /// 24 小时 不展示 秒
        case twentyFourMissSecond
    }
}
