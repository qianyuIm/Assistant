//
//  AppWidgetAttributes+BackgroundStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit

extension AppWidgetAttributes {
    enum BackgroundStyle: Codable, Equatable {
        case clear
        case color(color: AppWidgetColor)
        /// 当前只有本地图片
        case image(named: String)
        var image: UIImage? {
            switch self {
            case .clear, .color:
                return nil
            case .image(let named):
                return UIImage(named: named)
            }
        }
    }
}
