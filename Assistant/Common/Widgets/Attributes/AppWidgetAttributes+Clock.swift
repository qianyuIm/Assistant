//
//  AppWidgetAttributes+TimeFormat.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit

extension AppWidgetAttributes {
    enum ClockDisplayMode {
        /// 12小时
        case twelve
        /// 24 小时
        case twentyFour
        /// 12小时 不展示 秒
        case twelveMissSecond
        /// 24 小时 不展示 秒
        case twentyFourMissSecond
    }
    /// 优先图片
    struct ClockStyle: Equatable {
        /// 背景
        var backgroundImage: UIImage?
        /// 时针
        var hourHandImage: UIImage?
        var hourHandColor: UIColor?
        /// 分针
        var minutesHandImage: UIImage?
        var minutesHandColor: UIColor?
        /// 秒针
        var secondsHandImage: UIImage?
        var secondsColor: UIColor?
    }
}
