//
//  AppNotification.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Foundation

protocol AppNotificationable {
    associatedtype DefaultKeys: RawRepresentable
}

extension NotificationCenter {
    enum AppDelegate: AppNotificationable {
        enum DefaultKeys: String {
            case launched
        }
    }
    enum Languageau: AppNotificationable {
        enum DefaultKeys: String {
            case LCLLanguageChangeNotification
        }
    }
}

extension AppNotificationable where DefaultKeys.RawValue == String {
    static func post(_ name: DefaultKeys, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(
            name: conversion(name),
            object: object,
            userInfo: userInfo
        )
    }
    static func add(_ name: DefaultKeys, observer: Any, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: conversion(name),
            object: object
        )
    }
    static func add(_ name: DefaultKeys,
                    _ object: Any? = nil,
                    queue: OperationQueue = .main,
                    using block: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(
            forName: conversion(name),
            object: object,
            queue: .main,
            using: block
        )
    }
    static func remove(_ name: DefaultKeys, observer: Any, object: Any? = nil) {
        NotificationCenter.default.removeObserver(
            observer,
            name: conversion(name),
            object: object
        )
    }
    static private func conversion(_ key: DefaultKeys) -> NSNotification.Name {
        return NSNotification.Name(key.rawValue)
    }
}
