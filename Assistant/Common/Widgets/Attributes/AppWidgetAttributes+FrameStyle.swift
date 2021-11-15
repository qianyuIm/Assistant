//
//  AppWidgetAttributes+Border.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
// https://blog.csdn.net/hzhnzmyz/article/details/119872090

import UIKit
import AutoInch
extension AppWidgetAttributes {
    
    enum WidgetFamily {
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
    enum RoundCorners {
        case all(radius: CGFloat)
        
        var cornerValues: (value: UIRectCorner, radius: CGFloat) {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            }
        }
        
    }
    enum Border {
        case none
        case color(color: UIColor, width: CGFloat)
        case image(image: UIImage, width: CGFloat)
    }
}
