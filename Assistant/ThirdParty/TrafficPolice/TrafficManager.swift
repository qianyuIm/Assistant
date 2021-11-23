//
//  TrafficManager.swift
//  TrafficPolice
//
//  Created by 刘栋 on 2016/11/17.
//  Copyright © 2016年 anotheren.com. All rights reserved.
//

import Foundation
import Schedule

class TrafficManager {
    
    static let shared = TrafficManager()

    var interval: Double
    
    private var counter: TrafficCounter = TrafficCounter()
    
    private var summary: TrafficSummary?
    
    private init(interval: Double = 1.0) {
        self.interval = interval
    }
    
    func reset() {
        summary = nil
    }
    
    func start() {
        //        timer.start()
    }
    
    func cancel() {
        //        timer.suspend()
    }
    
    func updateSummary(with complete: ((_ summary: TrafficSummary) -> Void)? = nil) {
        let newSummary: TrafficSummary = {
            if let summary = self.summary {
                return summary.update(by: counter.usage, time: interval)
            } else {
                return TrafficSummary(origin: counter.usage)
            }
        }()
        complete?(newSummary)
        summary = newSummary
    }
}
