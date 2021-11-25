//
//  WidgetShared.swift
//  Assistant
//
//  Created by cyd on 2021/11/10.
//

import SwiftyUserDefaults
import Localize_Swift

var AppGroupDefaults = DefaultsAdapter(defaults: UserDefaults(suiteName: "group.com.qianyuIm.Assistant")!, keyStore: DefaultsKeys())

var AppGroupContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.qianyuIm.Assistant")!

extension DefaultsKeys {
    /// 主题模式
    var themeDisplayModeKey: DefaultsKey<AppDisplayMode> { .init("kThemeDisplayModeKey", defaultValue: .inferred) }
    ///  语言跟随系统
    var languageAutoSystem: DefaultsKey<Bool> { .init("kLanguageAutoSystemey", defaultValue: true) }
}

enum AppWidgetSharedKind {
    static var small: String { "SmallWidget_Kind" }
    static var medium: String { "MediumWidget_Kind" }
    static var large: String { "LargeWidget_Kind" }
}
struct AppWidgetPath {
    static let widgetsPath = AppGroupContainerURL.appendingPathComponent("AppWidgets")
    /// smallWidgets 存储位置
    static let smallWidgetsPath: String = {
        let path = widgetsPath.appendingPathComponent("SmallWidgets").absoluteString
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) { return path }
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch { }
        return path
    }()
    /// mediumlWidgets 存储位置
    static let mediumWidgetsPath: String = {
        let path = widgetsPath.appendingPathComponent("MediumWidgets").absoluteString
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) { return path }
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch { }
        return path
    }()
    /// largeWidgets 存储位置
    static let largeWidgetsPath: String = {
        let path = widgetsPath.appendingPathComponent("LargeWidgets").absoluteString
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) { return path }
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch { }
        return path
    }()
}

class AppWidgetShared {
    static var isEnglish: Bool {
        return Localize.currentLanguage() == "en"
    }
}

