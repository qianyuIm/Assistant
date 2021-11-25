//
//  AppWidgetConfig.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit

struct AppWidgetAttributes: Codable, Equatable {
    /// 展示名称
    var displayName: String {
        return "\(widgetType.displayName)\(widgetIndex)"
    }
    /// 唯一标识
    var identifier: String {
        return "\(widgetType.identifier)\(widgetIndex)"
    }
    /// 模式
    var displayMode = DisplayMode.inferred
    /// widget 类型
    var widgetType: WidgetType = .unknown
    /// 同类型widget
    var widgetIndex: Int = 1
    /// 背景
    var background = BackgroundStyle.image(named: "icon_widget_bg_32")
    /// 圆角
    var roundCorners = RoundCorners.all(radius: 10)
    /// 边框x
    var border = Border.none
    /// 小组件风格
    var widgetFamily = WidgetFamily.small
    /// 时钟显示样式
    var clockDisplayMode = ClockDisplayMode.twelve
    /// 圆形时钟
    var analogClockStyle = AnalogClockStyle()
    /// 字体和颜色
    var labelStyle = AppWidgetAttributes.LabelStyle()
    /// 保存到本地的时间
    var localTime: TimeInterval?
    /// 是否被使用
    var used: Bool = false
//    static func == (lhs: AppWidgetAttributes, rhs: AppWidgetAttributes) -> Bool {
//        return lhs.widgetType == rhs.widgetType &&
//        lhs.widgetIndex == rhs.widgetIndex &&
//        lhs.background == rhs.background &&
//        lhs.roundCorners == rhs.roundCorners &&
//        lhs.border == rhs.border &&
//        lhs.widgetFamily == rhs.widgetFamily &&
//        lhs.clockDisplayMode == rhs.clockDisplayMode &&
//        lhs.labelStyle == rhs.labelStyle
//    }
}

extension AppWidgetAttributes {
    init(with widgetType: AppWidgetAttributes.WidgetType,
         widgetIndex: Int) {
        self.widgetType = widgetType
        self.widgetIndex = widgetIndex
    }
    init(with labelStyle: AppWidgetAttributes.LabelStyle) {
        self.labelStyle = labelStyle
    }
    /// 保存到本地
    @discardableResult
    mutating func save(replace: Bool = false) -> Bool {
        let encoder = JSONEncoder()
        var directory = ""
        switch widgetFamily {
        case .small:
            directory = AppWidgetPath.smallWidgetsPath
        case .medium:
            directory = AppWidgetPath.mediumWidgetsPath
        case .large:
            directory = AppWidgetPath.largeWidgetsPath
        }
        let (path, retries) = AppWidgetShared.generate(directory: directory,
                                       fileName: identifier,
                                       retries: widgetIndex)
        localTime = Date().timeIntervalSince1970
        widgetIndex = retries
        do {
            let data = try encoder.encode(self)
            try data.write(to: URL(fileURLWithPath: path))
            return true
        } catch {
            widgetIndex = 1
            localTime = nil
        }
        return false
    }
    /// 替换 编辑页面使用
    /// - Returns:
    func replace() -> Bool {
        var directory = ""
        switch widgetFamily {
        case .small:
            directory = AppWidgetPath.smallWidgetsPath
        case .medium:
            directory = AppWidgetPath.mediumWidgetsPath
        case .large:
            directory = AppWidgetPath.largeWidgetsPath
        }
        let generate = directory + "/" + identifier
        if FileManager.default.fileExists(atPath: generate) {
            try? FileManager.default.removeItem(atPath: generate)
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: URL(fileURLWithPath: generate))
            return true
        } catch { }
        return false
    }
    static func smallWidgets() -> ([AppWidgetAttributes], [AppWidgetAttributes]) {
        var attributes: [AppWidgetAttributes] = []
        if let subpaths = AppWidgetShared.subpaths(atPath: AppWidgetPath.smallWidgetsPath) {
            let fileManager = FileManager.default
            for subpath in subpaths {
                let decoder = JSONDecoder()
                if let data = fileManager.contents(atPath: subpath) {
                    do {
                        let attribute = try decoder.decode(AppWidgetAttributes.self, from: data)
                        attributes.append(attribute)
                    } catch { }
                }
            }
            let used = attributes.filter { $0.used }.sorted { $0.localTime! > $1.localTime! }
            let unUse = attributes.filter { !$0.used }.sorted { $0.localTime! > $1.localTime! }
            return (unUse, used)
        }
        return ([], [])
    }
    static func mediumWidgets() -> [AppWidgetAttributes] {
        return []
    }
    static func largeWidgets() -> [AppWidgetAttributes] {
        return []
    }
}
