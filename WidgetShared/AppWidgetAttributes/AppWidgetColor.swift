//
//  AppWidgetColor.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//

import UIKit

//enum AppWidgetColors: Codable, CaseIterable {
//    
//}

struct AppWidgetColor: Codable, Equatable {
    private(set) var dark: String
    private(set) var light: String
    init(light: String, dark: String) {
        self.light = light
        self.dark = dark
    }
    init(_ unified: String) {
        self.light = unified
        self.dark = unified
    }

    func color(for traits: UITraitCollection,
               mode: AppWidgetAttributes.DisplayMode? = nil) -> UIColor {
        let appDisplayMode = AppGroupDefaults.themeDisplayModeKey
        switch appDisplayMode {
        case .inferred:
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return UIColor.app.color(hexString: light)
            case .dark:
                return UIColor.app.color(hexString: dark)
            @unknown default:
                return UIColor.app.color(hexString: light)
            }
        case .light:
            return UIColor.app.color(hexString: light)
        case .dark:
            return UIColor.app.color(hexString: dark)
        }
    }
}
