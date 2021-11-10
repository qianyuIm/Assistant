//
//  SmallWidgetIntentHandler.swift
//  IntentHandler
//
//  Created by cyd on 2021/11/10.
//

import Foundation
import Intents
 
class SmallWidgetIntentHandler: NSObject, SmallWidgetIntentHandling {
    
    func provideWidgetTypeOptionsCollection(for intent: SmallWidgetIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
//        let one = WidgetType(identifier: "12", display: "12",subtitle: "",image: INImage(named: "icon_relevance") )
//        let all = [one]
        completion(nil,nil)
    }
    func providePositionTypeOptionsCollection(for intent: SmallWidgetIntent, with completion: @escaping (INObjectCollection<PositionType>?, Error?) -> Void) {
        let followSystem = PositionType(identifier: "small_follow_system", display: "跟随app内设置",subtitle: nil,image: INImage(named: "icon_relevance"))
        let leftUp = PositionType(identifier: "small_left_up", display: "左上",subtitle: nil,image: INImage(named: "icon_small_up_left"))
        let rightUp = PositionType(identifier: "small_right_up", display: "右上",subtitle: nil,image: INImage(named: "icon_small_up_right"))
        let centerLeft = PositionType(identifier: "small_center_left", display: "左中",subtitle: nil,image: INImage(named: "icon_small_center_left"))
        let centerRight = PositionType(identifier: "small_center_right", display: "右中",subtitle: nil,image: INImage(named: "icon_small_center_right"))
        let leftDown = PositionType(identifier: "small_left_down", display: "左下",subtitle: nil,image: INImage(named: "icon_small_down_left"))
        let rightDown = PositionType(identifier: "small_right_down", display: "右下",subtitle: nil,image: INImage(named: "icon_small_down_right"))
        
        let allPosition = [followSystem, leftUp, rightUp, centerLeft, centerRight,leftDown, rightDown]
        completion(INObjectCollection(items: allPosition),nil)
    }
    
}
