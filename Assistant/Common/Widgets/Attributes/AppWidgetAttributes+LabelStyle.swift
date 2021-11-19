//
//  AppWidgetAttributes+LabelStyle.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import Foundation
import UIKit

extension AppWidgetAttributes {
    struct LabelStyle: Codable, Equatable {
        @CodableFont var font = QYFont.fontRegular(30)
        @CodableColor var textColor: UIColor = UIColor.black
        @CodableColor var backgroundColor: UIColor = UIColor.white
        var alignment: NSTextAlignment = .center
        var numberOfLines: Int = 0
        static func == (lhs: LabelStyle, rhs: LabelStyle) -> Bool {
            return lhs.font.fontName == rhs.font.fontName &&
            lhs.font.pointSize == rhs.font.pointSize &&
            lhs.textColor == rhs.textColor &&
            lhs.backgroundColor == rhs.backgroundColor &&
            lhs.alignment == rhs.alignment &&
            lhs.numberOfLines == rhs.numberOfLines
        }
    }
}
