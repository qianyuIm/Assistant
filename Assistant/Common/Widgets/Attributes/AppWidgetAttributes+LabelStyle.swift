//
//  AppWidgetAttributes+LabelStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit
extension AppWidgetAttributes {
    struct LabelStyle: Equatable {
        var font: UIFont = QYFont.fontRegular(30)
        var textColor: UIColor = UIColor.black
        var backgroundColor: UIColor = UIColor.white
        var alignment: NSTextAlignment = .center
        var numberOfLines: Int = 0
    }
}
