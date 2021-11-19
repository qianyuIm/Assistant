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
        case color(hexString: String)
        /// 当前只有本地图片
        case image(named: String)
        var color: UIColor? {
            switch self {
            case .clear,
                    .image:
                return nil
            case .color(let hexString):
                return UIColor.app.color(hexString: hexString)
            }
        }
        var image: UIImage? {
            switch self {
            case .clear,
                    .color:
                return nil
            case .image(let named):
                return UIImage(named: named)
            }
        }
    }
}
