//
//  AppUtility+Time.swift
//  Assistant
//
//  Created by cyd on 2021/11/23.
//

import Foundation

extension AppUtility {
    /// 返回上次关机的时间
    /// - Returns:
    class func systemUptime() -> Date {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        let now = Date().timeIntervalSince1970
        return Date(timeIntervalSince1970: now - systemUptime)
    }
}
