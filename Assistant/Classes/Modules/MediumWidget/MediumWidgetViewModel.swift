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
        let recommendSection = MediumWidgetSection
            .recommendSection(supplementary:
                                    .init(icon: R.image.icon_widget_section_recommend(),
                                          title: R.string.widgets
                                            .sectionRecommend.key
                                            .app.widgetsLocalized(),
                                          routerPattern: "",
                                          router: false),
                              items: [
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes())
                                
                              ])
        let generalToolsSection = MediumWidgetSection
            .generalToolsSection(supplementary:
                                        .init(icon: R.image.icon_widget_section_tools(),
                                              title: R.string.widgets
                                                .sectionGeneralTools.key
                                                .app.widgetsLocalized(),
                                              routerPattern: "",
                                              router: true),
                                 items: [
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes())
                                 ])
        
        
        return [recommendSection,generalToolsSection]
    }
}
