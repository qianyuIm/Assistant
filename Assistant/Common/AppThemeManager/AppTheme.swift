//
//  AppTheme.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit

/// tabbar主题配置
class TabbarTheme {
    let textColor: UIColor
    let highlightTextColor: UIColor
    let iconColor: UIColor
    let highlightIconColor: UIColor
    let barTintColor: UIColor
    init(textColor: UIColor,
         highlightTextColor: UIColor,
         iconColor: UIColor,
         highlightIconColor: UIColor,
         barTintColor: UIColor) {
        self.textColor = textColor
        self.highlightTextColor = highlightTextColor
        self.iconColor = iconColor
        self.highlightIconColor = highlightIconColor
        self.barTintColor = barTintColor
    }
}
/// 导航主题配置
class NavigationBarTheme {
    let barTintColor: UIColor
    let tintColor: UIColor
    let foregroundColor: UIColor
    /// 导航栏目前不需要设置
    let barStyle: UIBarStyle
    init(barTintColor: UIColor,
         tintColor: UIColor,
         foregroundColor: UIColor,
         barStyle: UIBarStyle) {
        self.barTintColor = barTintColor
        self.tintColor = tintColor
        self.foregroundColor = foregroundColor
        self.barStyle = barStyle
    }
}
/// 字体设置
class TextTheme {
    let titleColor: UIColor
    let subtitleColor: UIColor
    init(titleColor: UIColor,
         subtitleColor: UIColor) {
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
    }
}

/// 分段主题
struct SegmentedTheme {
    var titleNormalColor: UIColor
    var titleSelectedColor: UIColor
    var indicatorColor: UIColor
    var titleNormalFont: UIFont
    var titleSelectedFont: UIFont
}
