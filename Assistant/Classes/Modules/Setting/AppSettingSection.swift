//
//  AppSettingSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit
import RxDataSources

enum AppSettingSection {
    case profileSection(title: String, items: [AppSettingSectionItem])
    case configSection(title: String, items: [AppSettingSectionItem])
}
enum AppSettingSectionItem {
    case profileItem(viewMode: AppSettingCellViewModel)
    case languageItem(viewMode: AppSettingCellViewModel)
    case themeItem(viewMode: AppSettingCellViewModel)
    case permissionItem(viewMode: AppSettingCellViewModel)
    case aboutItem(viewMode: AppSettingCellViewModel)
    case questionItem(viewMode: AppSettingCellViewModel)
    case limitItem(viewMode: AppSettingCellViewModel)
    var viewModel: AppSettingCellViewModel {
        switch self {
        case .profileItem(let viewMode):
            return viewMode
        case .languageItem(let viewMode):
            return viewMode
        case .themeItem(let viewMode):
            return viewMode
        case .permissionItem(let viewMode):
            return viewMode
        case .aboutItem(let viewMode):
            return viewMode
        case .questionItem(let viewMode):
            return viewMode
        case .limitItem(let viewMode):
            return viewMode
        }
    }
}
extension AppSettingSection: SectionModelType {
    typealias Item = AppSettingSectionItem
    var title: String {
        switch self {
        case  .profileSection(let title, _):
            return title
        case  .configSection(let title, _):
            return title
        }
    }
    var items: [AppSettingSectionItem] {
        switch self {
        case  .profileSection(_, let items):
            return items
        case  .configSection(_, let items):
            return items
        }
    }
    init(original: AppSettingSection, items: [AppSettingSectionItem]) {
        switch original {
        case .profileSection(let title, let items):
            self = .profileSection(title: title, items: items)
        case .configSection(let title, let items):
            self = .configSection(title: title, items: items)
        }
    }
}
