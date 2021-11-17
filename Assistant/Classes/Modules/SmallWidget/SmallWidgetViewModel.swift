//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import Foundation
import SwiftEntryKit

class SmallWidgetViewModel: AppViewModel {
    
    var dataSource: [SmallWidgetSection]?
    required init() {
        super.init()
        self.dataSource = config()
    }
}

extension SmallWidgetViewModel {

    func config() -> [SmallWidgetSection] {
        let recommendSection = SmallWidgetSection
            .recommendSection(supplementary:
                                    .init(icon: R.image.icon_widget_section_recommend(),
                                          title: R.string.widgets
                                            .sectionRecommend.key
                                            .app.widgetsLocalized(),
                                          routerPattern: "",
                                          router: false),
                              items: [
                                .flipClockItem(attributes: AppWidgetAttributes(with: R.string.widgets.itemFlipClock_1.key.app.widgetsLocalized())),
                                .flipClockItem(attributes: AppWidgetAttributes(timeDisplayMode: .twelveMissSecond)),
                                .flipClockItem(attributes: AppWidgetAttributes(timeDisplayMode: .twentyFour)),
                                .flipClockItem(attributes: AppWidgetAttributes(timeDisplayMode: .twentyFourMissSecond))
                              ])
        let generalToolsSection = SmallWidgetSection
            .generalToolsSection(supplementary:
                                        .init(icon: R.image.icon_widget_section_tools(),
                                              title: R.string.widgets
                                                .sectionGeneralTools.key
                                                .app.widgetsLocalized(),
                                              routerPattern: "",
                                              router: true),
                                 items: [
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    
                                 ])
        
        let xPanelSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_panel(),
                                      title: R.string.widgets
                                        .sectionXPanel.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes()),
                            
                           ])
        
        let dashboardSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_dashBoard(),
                                      title: R.string.widgets
                                        .sectionDashboard.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let clockSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_clock(),
                                      title: R.string.widgets
                                        .sectionClock.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let quickLauncherSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_quick(),
                                      title: R.string.widgets
                                        .sectionQuickLauncher.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let calendarSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_calendar(),
                                      title: R.string.widgets
                                        .sectionCalendar.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let daysMatterSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_matter(),
                                      title: R.string.widgets
                                        .sectionDaysMatter.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let systemInfoSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_system(),
                                      title: R.string.widgets
                                        .sectionSystemInfo.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes()),
                            
                           ])
        
        let progressSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_progress(),
                                      title: R.string.widgets
                                        .sectionProgress.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        return [recommendSection]
        return [recommendSection,generalToolsSection,
                                xPanelSection,dashboardSection,
                                clockSection,quickLauncherSection,
                                calendarSection,daysMatterSection,
                                systemInfoSection,progressSection]
    }
}
