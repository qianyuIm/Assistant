//
//  AppWidgetAttributes+TimeFormat.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import AutoInch
import UIKit

extension AppWidgetAttributes {
    enum ClockDisplayMode: Int, Codable {
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
    struct ClockStyle: Codable, Equatable {
        /// 背景
        var backgroundImageName: String? = "icon_analog_clock_bg_4_dark"
        var backgroundHexColorString: String = "#000000"
        /// 根据屏幕写死他
        var size: CGSize {
            if Screen.Width.current == ._320 && Screen.Height.current == ._568 {
                return CGSize(width: 140, height: 140)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._667 {
                return CGSize(width: 148, height: 148)
            }
            return CGSize(width: 155, height: 155)
        }
        
        /// 时针
        var hourHandImageName: String? = "icon_analog_clock_hour_0"
        var hourHandHexColorString: String = "#000000"
        var hourHandSize: CGSize = CGSize(width: 6, height: 36)
        /// 分针
        var minutesHandImageName: String? = "icon_analog_clock_minute_0"
        var minutesHandHexColorString: String = "#000000"
        var minutesHandSize: CGSize = CGSize(width: 2, height: 10)
        /// 秒针
        var secondsHandImageName: String? = "icon_analog_clock_second_0"
        var secondsHexColorString: String = "#000000"
        var secondsHandSize: CGSize = CGSize(width: 1, height: 12)
    }
}
