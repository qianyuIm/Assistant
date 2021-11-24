//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxSwift
import RxCocoa

class LargeWidgetViewModel: AppViewModel {
    var dataSource: [LargeWidgetSection]?
    required init() {
        super.init()
        self.dataSource = config()
    }
}

extension LargeWidgetViewModel {
    func config() -> [LargeWidgetSection] {
        let clockSection = LargeWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_clock(),
                                      title: R.string.widgets
                                        .sectionClock.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes.flipClock(.large)),
                            .analogClockItem(attributes: AppWidgetAttributes.analogClock(.large))
                           ])
        let systemInfoSection = LargeWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_system(),
                                      title: R.string.widgets
                                        .sectionSystemInfo.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flowItem(attributes: AppWidgetAttributes.flow(.large))
                           ])
        return [clockSection, systemInfoSection]
    }
}
