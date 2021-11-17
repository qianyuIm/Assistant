//
//  SmallWidgetSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import RxDataSources
import AttributedString

enum SmallWidgetSection {
    /// 推荐
    case recommendSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 系统工具
    case generalToolsSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// X-面板
    case xPanelSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 仪表盘
    case dashboardSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 时钟
    case clockSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 捷径
    case quickLauncherSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 日历
    case calendarSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 倒数日
    case daysMatterSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 系统信息
    case systemInfoSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
    /// 进度
    case progressSection(supplementary: AppWidgetSupplementaryModel, items: [SmallWidgetSectionItem])
}

enum SmallWidgetSectionItem {
    /// 翻页时钟
    case flipClockItem(attributes: AppWidgetAttributes)
}

extension SmallWidgetSection: SectionModelType {
    typealias Item = SmallWidgetSectionItem
    var items: [SmallWidgetSectionItem] {
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
        case  .recommendSection(let item, _):
            return item
        case  .generalToolsSection(let item, _):
            return item
        case  .xPanelSection(let item, _):
            return item
        case  .dashboardSection(let item, _):
            return item
        case  .clockSection(let item, _):
            return item
        case  .quickLauncherSection(let item, _):
            return item
        case  .calendarSection(let item, _):
            return item
        case  .daysMatterSection(let item, _):
            return item
        case  .systemInfoSection(let item, _):
            return item
        case  .progressSection(let item, _):
            return item
        }
    }
    init(original: SmallWidgetSection, items: [SmallWidgetSectionItem]) {
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
