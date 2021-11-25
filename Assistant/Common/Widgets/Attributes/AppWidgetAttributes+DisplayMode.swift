//
//  AppWidgetAttributes+DisplayMode.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//

import Foundation

extension AppWidgetAttributes {
    enum DisplayMode: Int, Codable {
        case inferred
        case light
        case dark
    }
}
