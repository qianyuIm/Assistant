//
//  UIEdgeInsetsExtensions.swift
//  ios_app
//
//  Created by qy on 2021/10/30.
//

import UIKit

extension UIEdgeInsets: AppExtensionCompatible {}
extension AppExtensionWrapper where Base == UIEdgeInsets {
    /// 获取UIEdgeInsets在水平方向上的值
    var horizontalValue: CGFloat {
        return base.left + base.right
    }
    /// 获取UIEdgeInsets在垂直方向上的值
    var verticalValue: CGFloat {
        return base.top + base.bottom
    }
    ///
    func removeFloatMin() -> UIEdgeInsets {
        let top = base.top.app.removeFloatMin()
        let left = base.left.app.removeFloatMin()
        let bottom = base.bottom.app.removeFloatMin()
        let right = base.right.app.removeFloatMin()
        let result = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return result
    }
}
