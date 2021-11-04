//
//  UIImageViewExtensions.swift
//  ios_app
//
//  Created by cyd on 2021/10/28.
//

import UIKit
import SDWebImage


extension AppExtensionWrapper where Base: UIImageView {
    
    /// 设置网络图片
    /// - Parameter url:
    func setImage(with url: URL?,
                  placeholderImage placeholder: UIImage? = nil) {
        base.sd_imageTransition = .fade
        base.sd_setImage(with: url, placeholderImage: placeholder)
    }
    
}
