//
//  CGSizeExtensions.swift
//  ios_app
//
//  Created by qy on 2021/10/30.
//

import UIKit

extension CGSize: AppExtensionCompatible {}

extension AppExtensionWrapper where Base == CGSize {
    
    var rect: CGRect {
        return CGRect(origin: .zero, size: base)
    }
    /// 将一个CGSize像素对齐
    var flatted: CGSize {
        return CGSize(width: base.width.app
            .flat, height: base.height.app.flat)
    }
    
}
