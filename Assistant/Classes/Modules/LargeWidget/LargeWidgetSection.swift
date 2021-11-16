//
//  SmallWidgetSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import RxDataSources

enum LargeWidgetSection {
    /// 推荐
    case recommendSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 系统工具
    case generalToolsSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// X-面板
    case xPanelSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 仪表盘
    case dashboardSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 时钟
    case clockSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 捷径
    case quickLauncherSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 日历
    case calendarSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 倒数日
    case daysMatterSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 系统信息
    case systemInfoSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    /// 进度
    case progressSection(supplementary: AppWidgetSupplementaryModel,items: [LargeWidgetSectionItem])
    
}

enum LargeWidgetSectionItem {
    /// 翻页时钟
    case flipClockItem(attributes: AppWidgetAttributes)
}

extension LargeWidgetSection: SectionModelType {
    typealias Item = LargeWidgetSectionItem
    
    var items: [LargeWidgetSectionItem] {
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
    
    var supplementary: AppWidgetSupplementaryModel {
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
    
    init(original: LargeWidgetSection, items: [LargeWidgetSectionItem]) {
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
