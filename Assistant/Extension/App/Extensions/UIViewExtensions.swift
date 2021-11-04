//
//  UIViewExtensions.swift
//  ios_app
//
//  Created by cyd on 2021/10/27.
//

import UIKit


extension AppExtensionWrapper where Base: UIView {
    var x: CGFloat {
        get {
            return self.base.frame.origin.x
        }
        set {
            var f = self.base.frame
            f.origin.x = newValue
            self.base.frame = f
        }
    }
    var y: CGFloat {
        get {
            return self.base.frame.origin.y
        }
        set {
            var f = self.base.frame
            f.origin.y = newValue
            self.base.frame = f
        }
    }
    var width: CGFloat {
        get {
            return self.base.frame.width
        }
        set {
            var f = self.base.frame
            f.size.width = newValue
            self.base.frame = f
        }
    }
    var height: CGFloat {
        get {
            return self.base.frame.height
        }
        set {
            var f = self.base.frame
            f.size.height = newValue
            self.base.frame = f
        }
    }
    var bottom: CGFloat {
        get {
            return self.base.frame.origin.y + self.base.frame.size.height
        }
        set {
            var f = self.base.frame
            f.origin.y = newValue - f.size.height
            self.base.frame = f
        }
    }
    /// 添加圆角
    /// - Parameters:
    ///   - corners: eg: .bottomLeft  or  [.bottomLeft, .topRight]
    ///   - radius:
    func addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        base.layer.masksToBounds = true
        base.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        base.layer.cornerRadius = radius
    }
    /// 获取视图的导航控制器
    var navigationController: UINavigationController? {
        var nextResponder: UIResponder? = base
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UINavigationController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
}
