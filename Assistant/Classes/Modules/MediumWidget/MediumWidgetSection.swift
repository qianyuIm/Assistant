//
//  SmallWidgetSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import RxDataSources

enum MediumWidgetSection {
    /// 推荐
    case recommendSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 系统工具
    case generalToolsSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// X-面板
    case xPanelSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 仪表盘
    case dashboardSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 时钟
    case clockSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 捷径
    case quickLauncherSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 日历
    case calendarSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 倒数日
    case daysMatterSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 系统信息
    case systemInfoSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
    /// 进度
    case progressSection(supplementary: AppWidgetSupplementaryModel, items: [MediumWidgetSectionItem])
}

enum MediumWidgetSectionItem {
    /// 翻页时钟
    case flipClockItem(attributes: AppWidgetAttributes)
}

extension MediumWidgetSection: SectionModelType {
    typealias Item = MediumWidgetSectionItem
    var items: [MediumWidgetSectionItem] {
        switch self {
        case  .recommendSection(_, let items):
            return items
        case  .generalToolsSection(_, let items):
            return items
        case  .xPanelSection(_, let items):
            return items
        case  .dashboardSection(_, let items):
            return items
        case  .clockSection(_, let items):
            return items
        case  .quickLauncherSection(_, let items):
            return items
        case  .calendarSection(_, let items):
            return items
        case  .daysMatterSection(_, let items):
            return items
        case  .systemInfoSection(_, let items):
            return items
        case  .progressSection(_, let items):
            return items
        }
    }
    var supplementary: AppWidgetSupplementaryModel {
        switch self {
        case .recommendSection(let item, _):
            return item
        case .generalToolsSection(let item, _):
            return item
        case .xPanelSection(let item, _):
            return item
        case .dashboardSection(let item, _):
            return item
        case .clockSection(let item, _):
            return item
        case .quickLauncherSection(let item, _):
            return item
        case .calendarSection(let item, _):
            return item
        case .daysMatterSection(let item, _):
            return item
        case .systemInfoSection(let item, _):
            return item
        case .progressSection(let item, _):
            return item
        }
    }
    init(original: MediumWidgetSection, items: [MediumWidgetSectionItem]) {
        switch original {
        case .recommendSection(let supplementary, let items):
            self = .recommendSection(supplementary: supplementary, items: items)
        case .generalToolsSection(let supplementary, let items):
            self = .generalToolsSection(supplementary: supplementary, items: items)
        case .xPanelSection(let supplementary, let items):
            self = .xPanelSection(supplementary: supplementary, items: items)
        case .dashboardSection(let supplementary, let items):
            self = .dashboardSection(supplementary: supplementary, items: items)
        case .clockSection(let supplementary, let items):
            self = .clockSection(supplementary: supplementary, items: items)
        case .quickLauncherSection(let supplementary, let items):
            self = .quickLauncherSection(supplementary: supplementary, items: items)
        case .calendarSection(let supplementary, let items):
            self = .calendarSection(supplementary: supplementary, items: items)
        case .daysMatterSection(let supplementary, let items):
            self = .daysMatterSection(supplementary: supplementary, items: items)
        case .systemInfoSection(let supplementary, let items):
            self = .systemInfoSection(supplementary: supplementary, items: items)
        case .progressSection(let supplementary, let items):
            self = .progressSection(supplementary: supplementary, items: items)
        }
    }
}
