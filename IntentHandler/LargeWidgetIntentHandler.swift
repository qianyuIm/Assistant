//
//  LargeWidgetIntentHandler.swift
//  IntentHandler
//
//  Created by cyd on 2021/11/10.
//

import Foundation
import Intents

class LargeWidgetIntentHandler: NSObject, LargeWidgetIntentHandling {
    
    
    func provideWidgetTypeOptionsCollection(for intent: LargeWidgetIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
        let one = WidgetType(identifier: "12", display: "12",subtitle: "",image: INImage(named: "icon_relevance") )
        let all = [one]
        completion(nil,nil)
    }
    
    func providePositionTypeOptionsCollection(for intent: LargeWidgetIntent, with completion: @escaping (INObjectCollection<PositionType>?, Error?) -> Void) {
        let followSystem = PositionType(identifier: "large_follow_system", display: "跟随app内设置",subtitle: nil,image: INImage(named: "icon_relevance"))
        
        let up = PositionType(identifier: "large_up", display: "上",subtitle: nil,image: INImage(named: "icon_large_up"))
        
        
        let down = PositionType(identifier: "large_down", display: "下",subtitle: nil, image: INImage(named: "icon_large_down"))

        let allPosition = [followSystem, up, down]
        completion(INObjectCollection(items: allPosition),nil)
    }
    
    
    
//    func provideWidgetTypeOptionsCollection(for intent: LargeWidgetIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
//        completion(nil,nil)
//    }
//    func providePositionTypeOptionsCollection(for intent: LargeWidgetIntent, with completion: @escaping (INObjectCollection<PositionType>?, Error?) -> Void) {
        
//    }
//
}
