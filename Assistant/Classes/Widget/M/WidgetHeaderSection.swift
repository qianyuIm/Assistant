//
//  WidgetHeaderModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxDataSources

struct WidgetHeaderSection {
    var items: [Item]
}
struct WidgetHeaderItem {
    var imageName: String
    var pattern: String
}

extension WidgetHeaderSection: SectionModelType {
    typealias Item = WidgetHeaderItem
    init(original: WidgetHeaderSection, items: [WidgetHeaderItem]) {
        self = original
        self.items = items
    }
}

