//
//  WidgetHeaderModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxDataSources

struct AppHomeWidgetHeaderSection {
    var items: [Item]
}
struct AppHomeWidgetHeaderItem {
    var imageName: String
    var pattern: String
}

extension AppHomeWidgetHeaderSection: SectionModelType {
    typealias Item = AppHomeWidgetHeaderItem
    init(original: AppHomeWidgetHeaderSection, items: [AppHomeWidgetHeaderItem]) {
        self = original
        self.items = items
    }
}
