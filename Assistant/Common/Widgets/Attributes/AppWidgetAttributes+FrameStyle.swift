//
//  AppWidgetAttributes+Border.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
// https://blog.csdn.net/hzhnzmyz/article/details/119872090

import UIKit

extension AppWidgetAttributes {
    enum RoundCorners: Codable, Equatable {
        case all(radius: CGFloat)
        var cornerValues: (value: UIRectCorner, radius: CGFloat) {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            }
        }
    }
    enum Border: Codable, Equatable {
        case none
        case color(hexString: String, width: CGFloat)
        /// 当前只有本地图片
        case image(named: String, width: CGFloat)
        var color: UIColor? {
            switch self {
            case .none,
                    .image:
                return nil
            case .color(let hexString, _):
                return UIColor.app.color(hexString: hexString)
            }
        }
        var image: UIImage? {
            switch self {
            case .none,
                    .color:
                return nil
            case .image(let named, _):
                return UIImage(named: named)
            }
        }
    }
}
