//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import Foundation

class MediumWidgetViewModel: AppViewModel {
    var dataSource: [MediumWidgetSection]?
    required init() {
        super.init()
        self.dataSource = config()
    }
}
extension MediumWidgetViewModel {
    func config() -> [MediumWidgetSection] {
        let clockSection = MediumWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_clock(),
                                      title: R.string.widgets
                                        .sectionClock.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes.flipClock(.medium)),
                            .analogClockItem(attributes: AppWidgetAttributes.analogClock(.medium))
                           ])
        let systemInfoSection = MediumWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_system(),
                                      title: R.string.widgets
                                        .sectionSystemInfo.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flowItem(attributes: AppWidgetAttributes.flow(.medium))
                           ])
        return [clockSection, systemInfoSection]
    }
}
