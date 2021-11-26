//
//  CGRectExtensions.swift
//  ios_app
//
//  Created by qy on 2021/10/30.
//

import UIKit

extension CGRect: AppExtensionCompatible {}

extension AppExtensionWrapper where Base == CGRect {
    /// 通过 size 获取一个 x/y 为 0 的 CGRect
    static func rect(size: CGSize) -> CGRect {
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    var flatted: CGRect {
        return CGRect(x: base.minX.app.flat, y: base.minY.app.flat, width: base.width.app.flat, height: base.height.app.flat)
    }
    /// 判断一个 CGRect 是否存在NaN
    var isNaN: Bool {
        return base.origin.x.isNaN || base.origin.y.isNaN || base.size.width.isNaN || base.size.height.isNaN
    }
    /// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
    var isInf: Bool {
        return base.origin.x.isInfinite || base.origin.y.isInfinite || base.size.width.isInfinite || base.size.height.isInfinite
    }
    /// 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）
    var isValidated: Bool {
        return !base.isNull && !base.isInfinite && !self.isNaN && !self.isInf
    }
    /// 为一个CGRect叠加scale计算
    func apply(scale: CGFloat) -> CGRect {
        return CGRect(x: base.minX * scale, y: base.minY * scale, width: base.width * scale, height: base.height * scale).app.flatted
    }
    /// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
    func minXHorizontallyCenter(in parentRect: CGRect) -> CGFloat {
        return ((parentRect.width - base.width) / 2.0).app.flat
    }
    /// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
    func minYVerticallyCenter(in parentRect: CGRect) -> CGFloat {
        return ((parentRect.height - base.height) / 2.0).app.flat
    }
    /// 返回值：同一个坐标系内，
    /// 想要layoutingRect和已布局完成的referenceRect(self)保持垂直居中时
    /// layoutingRect的originY
    func minYVerticallyCenter(_ layoutingRect: CGRect) -> CGFloat {
        return base.minY + layoutingRect.app.minYVerticallyCenter(in: base)
    }

    /// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
    func minXHorizontallyCenter(_ layoutingRect: CGRect) -> CGFloat {
        return base.minX + layoutingRect.app.minXHorizontallyCenter(in: base)
    }

    /// 为给定的rect往内部缩小insets的大小
    func insetEdges(_ insets: UIEdgeInsets) -> CGRect {
        let newX = base.minX + insets.left
        let newY = base.minY + insets.top
        let newWidth = base.width - insets.app.horizontalValue
        let newHeight = base.height - insets.app.verticalValue
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    /// 向上偏移
    func float(top: CGFloat) -> CGRect {
        var result = base
        result.origin.y = top
        return result
    }
    /// 向下偏移
    func float(bottom: CGFloat) -> CGRect {
        var result = base
        result.origin.y = bottom - base.height
        return result
    }
    /// 向右偏移
    func float(right: CGFloat) -> CGRect {
        var result = base
        result.origin.x = right - base.width
        return result
    }
     /// 向左偏移
    func float(left: CGFloat) -> CGRect {
        var result = base
        result.origin.x = left
        return result
    }

    /// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
    func limit(right: CGFloat) -> CGRect {
        var result = base
        result.size.width = right - base.minX
        return result
    }

    /// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
    /// 先改变origin.x，让其靠在offset上
    /// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
    func limit(left: CGFloat) -> CGRect {
        var result = base
        let subOffset = left - base.minX
        result.origin.x = left
        result.size.width -= subOffset
        return result
    }

    /// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
    func limit(maxWidth: CGFloat) -> CGRect {
        var result = base
        result.size.width = base.width > maxWidth ? maxWidth : base.width
        return result
    }

    func setX(_ x: CGFloat) -> CGRect {
        var result = base
        result.origin.x = x.app.flat
        return result
    }

    func setY(_ y: CGFloat) -> CGRect {
        var result = base
        result.origin.y = y.app.flat
        return result
    }

    func setXY(_ x: CGFloat, _ y: CGFloat) -> CGRect {
        var result = base
        result.origin.x = x.app.flat
        result.origin.y = y.app.flat
        return result
    }

    func setWidth(_ width: CGFloat) -> CGRect {
        var result = base
        result.size.width = width.app.flat
        return result
    }

    func setHeight(_ height: CGFloat) -> CGRect {
        var result = base
        result.size.height = height.app.flat
        return result
    }

    func setSize(size: CGSize) -> CGRect {
        var result = base
        result.size = size.app.flatted
        return result
    }
    /// 精度调节
    func fixed(_ precision: Int) -> CGRect {
        let x = base.origin.x.app.fixed(precision)
        let y = base.origin.y.app.fixed(precision)
        let width = base.width.app.fixed(precision)
        let height = base.height.app.fixed(precision)
        let result = CGRect(x: x, y: y, width: width, height: height)
        return result
    }
    func removeFloatMin() -> CGRect {
        let x = base.origin.x.app.removeFloatMin()
        let y = base.origin.y.app.removeFloatMin()
        let width = base.width.app.removeFloatMin()
        let height = base.height.app.removeFloatMin()
        let result = CGRect(x: x, y: y, width: width, height: height)
        return result
    }
    static func circle(center: CGPoint, radius: CGFloat) -> CGRect {
        return CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
    var center: CGPoint { CGPoint(x: base.midX, y: base.midY) }
    var radius: CGFloat { min(base.width, base.height)/2 }
}
