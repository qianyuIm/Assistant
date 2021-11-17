//
//  CGFloatExtensions.swift
//  ios_app
//
//  Created by qy on 2021/10/30.
//

import UIKit

extension CGFloat: AppExtensionCompatible {}

extension AppExtensionWrapper where Base == CGFloat {

    var scale: CGFloat {
        return self.base / UIScreen.main.scale
    }
    /// 基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
    /// 注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是
    /// 否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，
    /// 而应该用 flatSpecificScale
    var flat: CGFloat {
        return self.flatSpecificScale(scale: 0)
    }
    /// 基于指定的倍数，对传进来的 floatValue 进行像素取整。
    /// 若指定倍数为0，则表示以当前设备的屏幕倍数为准。
    /// 例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），
    /// 在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
    func flatSpecificScale(scale: CGFloat) -> CGFloat {
        let sca = scale == 0 ? UIScreen.main.scale : scale
        return ceil(self.base * sca) / sca
    }
    
     ///  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
     /// issue: https://github.com/QMUI/QMUI_iOS/issues/203
    func removeFloatMin() -> CGFloat {
        return base == CGFloat.leastNormalMagnitude ? 0 : base
    }
    /// 调整给定的某个 CGFloat 值的小数点精度，超过精度的部分按四舍五入处理。
    /// 例如 0.3333.fixed(2) 会返回 0.33，而 0.6666.fixed(2) 会返回 0.67
    /// 该方法无法解决浮点数精度运算的问题
    func fixed(_ precision: Int) -> CGFloat {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = precision
        var cgFloat:CGFloat = 0
        if let result = formatter.string(from: NSNumber(value: Double(base))),
            let doubleValue = Double(result) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    /// 用于居中运算
    func center(_ child: CGFloat) -> CGFloat {
        return ((base - child) / 2.0).app.flat
    }
}
