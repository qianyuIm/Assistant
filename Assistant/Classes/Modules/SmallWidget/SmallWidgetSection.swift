//
//  SmallWidgetSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import RxDataSources

enum SmallWidgetSection {
    /// 推荐
    case recommendSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 系统工具
    case generalToolsSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// X-面板
    case xPanelSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 仪表盘
    case dashboardSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 时钟
    case clockSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 捷径
    case quickLauncherSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 日历
    case calendarSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 倒数日
    case daysMatterSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 系统信息
    case systemInfoSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    /// 进度
    case progressSection(supplementary: WidgetSupplementaryModel,items: [SmallWidgetSectionItem])
    
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
        case  .generalToolsSection(_ ,let items):
            return items
        case  .xPanelSection(_ ,let items):
            return items
        case  .dashboardSection(_ ,let items):
            return items
        case  .clockSection(_ ,let items):
            return items
        case  .quickLauncherSection(_ ,let items):
            return items
        case  .calendarSection(_ ,let items):
            return items
        case  .daysMatterSection(_ ,let items):
            return items
        case  .systemInfoSection(_ ,let items):
            return items
        case  .progressSection(_ ,let items):
            return items
        }
    }
    
    var supplementary: WidgetSupplementaryModel {
        switch self {
        case  .recommendSection(let su, _):
            return su
        case  .generalToolsSection(let su, _):
            return su
        case  .xPanelSection(let su, _):
            return su
        case  .dashboardSection(let su, _):
            return su
        case  .clockSection(let su, _):
            return su
        case  .quickLauncherSection(let su, _):
            return su
        case  .calendarSection(let su, _):
            return su
        case  .daysMatterSection(let su, _):
            return su
        case  .systemInfoSection(let su, _):
            return su
        case  .progressSection(let su, _):
            return su
        }
    }
    
    init(original: SmallWidgetSection, items: [SmallWidgetSectionItem]) {
        switch original {
        case .recommendSection(let supplementary,let items):
            self = .recommendSection(supplementary: supplementary,items: items)
        case .generalToolsSection(let supplementary,let items):
            self = .generalToolsSection(supplementary: supplementary,items: items)
        case .xPanelSection(let supplementary,let items):
            self = .xPanelSection(supplementary: supplementary,items: items)
        case .dashboardSection(let supplementary,let items):
            self = .dashboardSection(supplementary: supplementary,items: items)
        case .clockSection(let supplementary,let items):
            self = .clockSection(supplementary: supplementary,items: items)
        case .quickLauncherSection(let supplementary,let items):
            self = .quickLauncherSection(supplementary: supplementary,items: items)
        case .calendarSection(let supplementary,let items):
            self = .calendarSection(supplementary: supplementary,items: items)
        case .daysMatterSection(let supplementary,let items):
            self = .daysMatterSection(supplementary: supplementary,items: items)
        case .systemInfoSection(let supplementary,let items):
            self = .systemInfoSection(supplementary: supplementary,items: items)
        case .progressSection(let supplementary,let items):
            self = .progressSection(supplementary: supplementary,items: items)
        }
    }
}
