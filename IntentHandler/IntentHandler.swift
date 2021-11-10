//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by cyd on 2021/11/9.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is SmallWidgetIntent {
            return SmallWidgetIntentHandler()
        }
        if intent is MediumWidgetIntent {
            return MediumWidgetIntentHandler()
        }
        if intent is LargeWidgetIntent {
            return LargeWidgetIntentHandler()
        }
        fatalError("Unhandled intent type: \(intent)")
    }
    
}
