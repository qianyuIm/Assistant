//
//  QYImage.swift
//  ios_app
//
//  Created by cyd on 2021/10/28.
//

import UIKit

struct QYImage {
    /// 占位图
    static var placeholder: UIImage? {
        return image(color: QYColor.placeholder)
    }
    static func image(color: UIColor,
                      size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    

}
