//
//  AppWidgetEditViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//

import Foundation

class AppWidgetEditViewModel: AppViewModel {

    var attributes: AppWidgetAttributes
     init(with attributes: AppWidgetAttributes) {
         self.attributes = attributes
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
