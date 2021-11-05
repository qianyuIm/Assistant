//
//  AppSettingSection.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit
import RxDataSources

enum AppSettingSection {
    case languageSection(title: String,items: [AppSettingSectionItem])
    case themeSection(title: String,items: [AppSettingSectionItem])
}
enum AppSettingSectionItem {
    case languageItem(viewMode: AppSettingCellViewModel)
    case themeItem(viewMode: AppSettingCellViewModel)
}
