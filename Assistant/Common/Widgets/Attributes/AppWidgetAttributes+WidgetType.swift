//
//  AppWidgetAttributes+WidgetType.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//

import UIKit
import Localize_Swift

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
        /// 系统信息 -> 数据流量
        case flow

        var name: String {
            let isEnglish = QYConfig.Language.isEnglish
            switch self {
            case .unknown:
                return ""
            case .flipClock:
                return isEnglish ? "翻页时钟#" : "Flip Clock#"
            case .flow:
                return isEnglish ? "数据流量" : "Flow"
            }
        }
        /// 唯一标识
        var identifier: String {
            switch self {
            case .unknown:
                return ""
            case .flipClock:
                return "FlipClock#"
            case .flow:
                return "Flow"
            }
        }
    }
}
