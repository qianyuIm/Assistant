//
//  QYDefaultKeys.swift
//  ios_app
//
//  Created by cyd on 2021/10/12.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    /// 进入后台时间
    var enterBackgroundTimeKey: DefaultsKey<Double> { .init("kEnterBackgroundKey", defaultValue: 0) }
    /// 进入前台时间
    var enterForegroundTimeKey: DefaultsKey<Double> { .init("kEnterForegroundKey", defaultValue: 0) }
    /// 启动隐私协议
    var launchPrivacyPolicyKey: DefaultsKey<String> { .init("KLaunchPrivacyPolicyKey", defaultValue: "")  }
    /// 是否为夜间模式
    var themeDarkModeKey: DefaultsKey<Bool> { .init("kThemeDarkModeKey", defaultValue: false) }
    var themeDisplayModeKey: DefaultsKey<QYConfig.Theme.DisplayMode> { .init("kThemeDisplayModeKey", defaultValue: QYConfig.Theme.DisplayMode.inferred) }
    /// 主题位置
    var themeSwatchIndexKey: DefaultsKey<Int> { .init("kThemeSwatchIndexKey", defaultValue: 0) }
    ///  主题跟随系统
    var themeAutoSystem: DefaultsKey<Bool> { .init("kThemeAutoSystemKey", defaultValue: true) }
    ///  语言跟随系统
    var languageAutoSystem: DefaultsKey<Bool> { .init("kLanguageAutoSystemey", defaultValue: true) }
    
}
