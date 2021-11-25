//
//  AppWidgetAttributes+LabelStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit

extension AppWidgetAttributes {
    struct LabelStyle: Codable, Equatable {
        var fontName: AppWidgetFontName = .normal
        var fontSize: CGFloat = 14
        var textColor: AppWidgetColor = .init("000000")
        var backgroundColor: AppWidgetColor = .init("FFFFFF")
        var font: UIFont? {
            return QYFont.font(fontName.rawValue, fontSize: fontSize)
        }
    }
}
