//
//  QYInch.swift
//  ios_app
//
//  Created by cyd on 2021/10/12.
//

import Foundation
import AutoInch

struct QYInch {
    static private var _isAdapter: Bool = false
    static func _adapter() {
        if (!_isAdapter) {
            _isAdapter = true
            Auto.set { origin in
                guard UIDevice.current.userInterfaceIdiom == .phone else {
                    return origin
                }
                let base = 375.0
                let screenWidth = Double(UIScreen.main.bounds.width)
                let screenHeight = Double(UIScreen.main.bounds.height)
                let width = min(screenWidth, screenHeight)
                let result = origin * (width / base)
                let scale = Double(UIScreen.main.scale)
                return (result * scale).rounded(.up) / scale
            }
        }
        
    }
    /// 是否为刘海屏  x 系列
    static let isFull: Bool = (AutoInch.Screen.isFull)
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.height
    /// 44 or 20  iphone12  除 mini外都为 为47 不适配 47 情况了
    static let statusBarHeight: CGFloat = isFull ? 44.0 : 20.0
    /// 
    static let tabbarHeight: CGFloat = isFull ? 83.0 : 49.0
    /// 比例
    static let scale = UIScreen.main.scale
    /// 比例
    static let left = value(16)
    /// 比例
    static let right = value(16)
    
    
    /// 适配
    static func value(_ value: CGFloat) -> CGFloat {
        return value.auto()
    }
    
    /// 根据宽高比 和宽度求出高度
    /// - Parameters:
    ///   - width: 当前宽度
    ///   - aspectRatio: 实际宽高比
    /// - Returns:
    static func height(width: CGFloat, aspectRatio: CGFloat) -> CGFloat {
        return width / aspectRatio
    }
    
    /// 占位图大小
    static let placeholder = value(150)
}
