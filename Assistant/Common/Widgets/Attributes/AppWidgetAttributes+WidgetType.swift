//
//  AppWidgetAttributes+WidgetType.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//

import UIKit

extension AppWidgetAttributes {
    enum WidgetFamily: Int, Codable, Equatable {
        case small
        case medium
        case large
        var value: CGSize {
            switch self {
            case .small:
                return QYInch.Widget.smallSize
            case .medium:
                return QYInch.Widget.mediumSize
            case .large:
                return QYInch.Widget.largeSize
            }
        }
    }
    enum WidgetType: Codable, Equatable {

        case unknown
        /// 翻页时钟
        case flipClock
        /// 模拟时钟 -> 圆形时钟
        case analogClock
        /// 系统信息 -> 数据流量
        case flow

        var displayName: String {
            let isEnglish = QYConfig.Language.isEnglish
            switch self {
            case .unknown:
                return ""
            case .flipClock:
                return isEnglish ? "翻页时钟#" : "Flip Clock#"
            case .analogClock:
                return isEnglish ? "圆形时钟#" : "Analog Clock#"
            case .flow:
                return isEnglish ? "数据流量#" : "Flow#"
            }
        }
        /// 唯一标识
        var identifier: String {
            switch self {
            case .unknown:
                return ""
            case .flipClock:
                return "FlipClock#"
            case .analogClock:
                return "FlipClock#"
            case .flow:
                return "Flow"
            }
        }
    }
}
