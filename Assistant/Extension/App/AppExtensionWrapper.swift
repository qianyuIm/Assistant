//
//  AppWrapper.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import Foundation

struct AppExtensionWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

protocol AppExtensionCompatible {
    associatedtype CompatibleType
    static var app: AppExtensionWrapper<CompatibleType>.Type { get set }
    var app: AppExtensionWrapper<CompatibleType> { get set }
}

extension AppExtensionCompatible {
    // swiftlint:disable unused_setter_value
    public static var app: AppExtensionWrapper<Self>.Type {
        get {
            return AppExtensionWrapper<Self>.self
        }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }
    // swiftlint:disable unused_setter_value
    public var app: AppExtensionWrapper<Self> {
        get {
            return AppExtensionWrapper(self)
        }
        set {
           
        }
    }
}

extension NSObject: AppExtensionCompatible {}
