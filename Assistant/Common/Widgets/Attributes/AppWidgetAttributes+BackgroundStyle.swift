//
//  AppWidgetAttributes+BackgroundStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit

extension AppWidgetAttributes {
    enum BackgroundStyle: Equatable {
        case clear
        case color(color: UIColor)
        case image(image: UIImage)
    }
}
