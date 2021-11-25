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
        case value(color: AppWidgetColor, width: CGFloat)
    }
}
