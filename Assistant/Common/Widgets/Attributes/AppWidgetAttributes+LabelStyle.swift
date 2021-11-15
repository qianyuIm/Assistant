//
//  AppWidgetAttributes+LabelStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit
extension AppWidgetAttributes {
    struct LabelStyle {
        var font: UIFont = QYFont.fontRegular(12)
        var color: UIColor = UIColor.red
        var alignment: NSTextAlignment = .center
        var numberOfLines: Int = 0
    }
}
