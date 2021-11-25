//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import Foundation

class SmallWidgetViewModel: AppViewModel {

    var dataSource: [SmallWidgetSection]?
    required init() {
        super.init()
        self.dataSource = config()
    }
}

extension SmallWidgetViewModel {

    func config() -> [SmallWidgetSection] {
        let clockSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_clock(),
                                      title: R.string.widgets
                                        .sectionClock.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes.flipClock(.small)),
                            .analogClockItem(attributes: AppWidgetAttributes.analogClock(.small))
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
                            .flowItem(attributes: AppWidgetAttributes.flow(.small))
                           ])
        return [clockSection, systemInfoSection]
    }
}
