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
    static func adapter() {
        if !_isAdapter {
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
    /// 单一线段高度
    static let singleLineHeight = 1 / scale
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
    struct Widget {
        static var smallSize: CGSize {
            var size: CGSize = CGSize.zero
            if Screen.Width.current == ._320 && Screen.Height.current == ._568 {
                size = CGSize(width: 140, height: 140)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._667 {
                size = CGSize(width: 148, height: 148)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._812 {
                size = CGSize(width: 155, height: 155)
            } else if Screen.Width.current == ._390 && Screen.Height.current == ._844 {
                size = CGSize(width: 158, height: 158)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._736 {
                size = CGSize(width: 157, height: 157)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._896 {
                size = CGSize(width: 169, height: 169)
            } else {
                /// 428 x 926
                size = CGSize(width: 170, height: 170)
            }
            return size
        }
        static var mediumSize: CGSize {
            var size: CGSize = CGSize.zero
            if Screen.Width.current == ._320 && Screen.Height.current == ._568 {
                size = CGSize(width: 291, height: 140)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._667 {
                size = CGSize(width: 321, height: 148)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._812 {
                size = CGSize(width: 329, height: 155)
            } else if Screen.Width.current == ._390 && Screen.Height.current == ._844 {
                size = CGSize(width: 338, height: 158)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._736 {
                size = CGSize(width: 348, height: 157)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._896 {
                size = CGSize(width: 360, height: 169)
            } else {
                /// 428 x 926
                size = CGSize(width: 364, height: 170)
            }
            return size
        }
        static var largeSize: CGSize {
            var size: CGSize = CGSize.zero
            if Screen.Width.current == ._320 && Screen.Height.current == ._568 {
                size = CGSize(width: 291, height: 310)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._667 {
                size = CGSize(width: 321, height: 324)
            } else if Screen.Width.current == ._375 && Screen.Height.current == ._812 {
                size = CGSize(width: 329, height: 345)
            } else if Screen.Width.current == ._390 && Screen.Height.current == ._844 {
                size = CGSize(width: 338, height: 354)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._736 {
                size = CGSize(width: 348, height: 351)
            } else if Screen.Width.current == ._414 && Screen.Height.current == ._896 {
                size = CGSize(width: 369, height: 379)
            } else {
                /// 428 x 926
                size = CGSize(width: 364, height: 382)
            }
            return size
        }
        static var aspectRatio: CGFloat = 1.3
        /// 大组件 纵横比缩放
        static var largeAspectRatioSize: CGSize {
            return CGSize(width: largeSize.width / aspectRatio, height: largeSize.height / aspectRatio)
        }
    }
}
