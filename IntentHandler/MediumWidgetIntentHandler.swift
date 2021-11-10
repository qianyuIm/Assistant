//
//  MediumWidgetIntentHandler.swift
//  IntentHandler
//
//  Created by cyd on 2021/11/10.
//

import Foundation
import Intents

class MediumWidgetIntentHandler: NSObject, MediumWidgetIntentHandling {
    func provideWidgetTypeOptionsCollection(for intent: MediumWidgetIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
        let one = WidgetType(identifier: "12", display: "12",subtitle: "",image: INImage(named: "icon_relevance") )
        let all = [one]
        completion(nil,nil)
    }
    
    func providePositionTypeOptionsCollection(for intent: MediumWidgetIntent, with completion: @escaping (INObjectCollection<PositionType>?, Error?) -> Void) {
        
        let followSystem = PositionType(identifier: "medium_follow_system", display: NSLocalizedString("Position.System", comment: ""),subtitle: nil,image: INImage(named: "icon_relevance"))
        
        let up = PositionType(identifier: "medium_up", display: NSLocalizedString("Position.Top", comment: ""),subtitle: nil,image: INImage(named: "icon_medium_up"))
        
        let center = PositionType(identifier: "medium_center", display: NSLocalizedString("Position.Center", comment: ""),subtitle: nil,image: INImage(named: "icon_medium_center"))
        
        
        let down = PositionType(identifier: "medium_down", display: NSLocalizedString("Position.Down", comment: ""),subtitle: nil,image: INImage(named: "icon_medium_down"))

        let allPosition = [followSystem, up, center, down]
        completion(INObjectCollection(items: allPosition),nil)
    }
    
    
    
    
    
//    func provideWidgetTypeOptionsCollection(for intent: MediumWidgetIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
//        completion(nil,nil)
//    }
//    func providePositionTypeOptionsCollection(for intent: MediumWidgetIntent, with completion: @escaping (INObjectCollection<PositionType>?, Error?) -> Void) {
//        let followSystem = PositionType(identifier: "follow_system", display: "跟随app内设置",subtitle: nil,image: INImage(named: "icon_relevance"))
//        let leftUp = PositionType(identifier: "left_up", display: "左上",subtitle: nil,image: INImage(named: "icon_small_up_left"))
//        let rightUp = PositionType(identifier: "right_up", display: "右上",subtitle: nil,image: INImage(named: "icon_small_up_right"))
//        let centerLeft = PositionType(identifier: "center_left", display: "左中",subtitle: nil,image: INImage(named: "icon_small_center_left"))
//        let centerRight = PositionType(identifier: "center_right", display: "右中",subtitle: nil,image: INImage(named: "icon_small_center_right"))
//        let leftDown = PositionType(identifier: "left_down", display: "左下",subtitle: nil,image: INImage(named: "icon_small_down_left"))
//        let rightDown = PositionType(identifier: "right_down", display: "右下",subtitle: nil,image: INImage(named: "icon_small_down_right"))
//        
//        let allPosition = [followSystem, leftUp, rightUp, centerLeft, centerRight,leftDown, rightDown]
//        completion(INObjectCollection(items: allPosition),nil)
//    }
//    
}
