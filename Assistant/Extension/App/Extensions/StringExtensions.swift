//
//  StringExtensions.swift
//  ios_app
//
//  Created by cyd on 2021/10/28.
//

import UIKit

extension String: AppExtensionCompatible {}

// MARK: image
extension AppExtensionWrapper where Base == String {
    
    /// 返回处理之后的图片链接 根据屏幕调整比例
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 高度
    /// - Returns:
    func imageScaleCompressUrl(width: CGFloat,height:CGFloat) -> URL? {
        guard !self.base.isEmpty else { return nil }
        let realWidth = width * QYInch.scale
        let realHeight = height * QYInch.scale
        let urlString = self.base + "?param=\(Int(realWidth))y\(Int(realHeight))"
        return URL(string: urlString)
    }
    
    /// 返回处理之后的图片链接
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 高度
    /// - Returns:
    func imageCompressUrl(width: CGFloat,height:CGFloat) -> URL? {
        guard !self.base.isEmpty else { return nil }
        let urlString = self.base + "?param=\(Int(width))y\(Int(height))"
        return URL(string: urlString)
    }
    /// 文件名(带后缀)
    var lastPathComponent: String {
        return (base as NSString).lastPathComponent
    }
    var deletingLastPathComponent: String {
        return (base as NSString).deletingLastPathComponent
    }
    /// 文件名(不带后缀)
    var deletingPathExtension:String {
        return (base as NSString).deletingPathExtension
    }
    /// 文件扩展名
    var pathExtension: String {
        return (base as NSString).pathExtension
    }
}
