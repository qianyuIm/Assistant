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
    struct AnalogClockStyle: Codable, Equatable {
        enum BackgroundStyle: Int, Codable, Equatable {
            /// 圆盘
            case minimal
            case style1
            case style2
            case style3
        }
        struct Size: Codable, Equatable {
            /// 根据屏幕写死它 富裕边界 居中布局
            var backgroundSize: CGSize {
                if Screen.Width.current == ._320 && Screen.Height.current == ._568 {
                    return CGSize(width: 130, height: 130)
                } else if Screen.Width.current == ._375 && Screen.Height.current == ._667 {
                    return CGSize(width: 140, height: 140)
                }
                return CGSize(width: 146, height: 146)
            }
            /// 背景内边距
            var backgroundMargen: CGFloat = 4
            var textMargen: CGFloat {
                return 3 * backgroundMargen + largeGraduationSize.height
            }
            /// 时针大小
            var hourHandSize: CGSize = CGSize(width: 4, height: 50)
            /// 分针大小
            var minutesHandSize: CGSize = CGSize(width: 3, height: 54)
            /// 秒针大小
            var secondsHandSize: CGSize = CGSize(width: 2, height: 60)
            var circleRadius: CGFloat {
                return min(backgroundSize.width, backgroundSize.height) / 2
            }
            var circleCenter: CGPoint {
                return CGPoint(x: backgroundSize.width / 2, y: backgroundSize.height / 2)
            }
            var largeGraduationSize: CGSize = CGSize(width: 3, height: 6)
            var smallGraduationSize: CGSize = CGSize(width: 2, height: 3)
        }
        /// 适用于 Analog Clock 显示模式
        var backgroundStyle: AnalogClockStyle.BackgroundStyle = .style3
        /// 背景
//        var backgroundImageName: String? = "icon_analog_clock_bg_4_dark"
        var backgroundImageName: String?
        var backgroundHexColorString: String = "#F0F"
        var size: AnalogClockStyle.Size = AnalogClockStyle.Size()
        /// 时针
//        var hourHandImageName: String? = "icon_analog_clock_hour_0"
        var hourHandImageName: String?
        var hourHandHexColorString: String = "#000000"
        /// 分针
//        var minutesHandImageName: String? = "icon_analog_clock_minute_0"
        var minutesHandImageName: String?
        var minutesHandHexColorString: String = "#fff"
        /// 秒针
//        var secondsHandImageName: String? = "icon_analog_clock_second_0"
        var secondsHandImageName: String?
        var secondsHexColorString: String = "#000000"
        /// 大刻度颜色
        var largeGraduationHexColorString: String = "#0f0"
        /// 大刻度颜色
        var smallGraduationHexColorString: String = "#0f0"
    }
}
