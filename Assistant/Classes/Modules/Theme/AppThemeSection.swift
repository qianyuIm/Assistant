//
//  AppThemeSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/12.
//

import RxDataSources
import UIKit

struct AppThemeItem {
    var colorSwatch: AppColorSwatch
    var isSelected: Bool
}

struct AppThemeModeItem {
    var displayMode: AppDisplayMode
    var disPlayName: String
    var isSelected: Bool
}

enum AppThemeSection {
    case settingSection(items: [AppThemeSectionItem])
    case themeSection(items: [AppThemeSectionItem])
    var rowCount: Int {
        switch self {
        case .settingSection:
            return 1
        case .themeSection:
            return 3
        }
    }
}
enum AppThemeSectionItem {
    case settingSectionItem(item: AppThemeModeItem)
    case themeSectionItem(item: AppThemeItem)
}

extension AppThemeSection: SectionModelType {
    typealias Item = AppThemeSectionItem
    var items: [AppThemeSectionItem] {
        switch self {
        case  .settingSection(let items):
            return items
        case  .themeSection(let items):
            return items
        }
    }
    init(original: AppThemeSection, items: [AppThemeSectionItem]) {
        switch original {
        case .settingSection(let items):
            self = .settingSection(items: items)
        case .themeSection(let items):
            self = .themeSection(items: items)
        }
    }
}
