//
//  QYConfig.swift
//  ios_app
//
//  Created by cyd on 2021/10/14.
//

import UIKit

struct QYConfig {
    /// 启动页面展示 前后台时间间隔  默认: 60 * 3 s
    static let showEnterForegroundAdTimeInterval: Double = 10 * 3
    static let channel = "pgy"
    static let alias = "assistant"
    static let appDisplayName = R.string.infoPlist.cfBundleDisplayName()
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    static let scheme = "assistant://"
    static let userAgent = "assistant/\(appVersion)"
    
    
    
    struct Value {
        /// -1
        static let undefinedValue: CGFloat = -1
    }
    struct Notification {
        /// 只有 category 匹配才会使用 NotificationContentExtension
        static let contentExtensionCategory = "contentExtensionCategory"
        static let serviceExtensionCategory = "serviceExtensionCategory"
        static let notInterestedActionIdentifier = "notInterestedAction"
        static let openActionIdentifier = "openAction"
        static let mediaType = "mediaType"
        static let mediaUrl = "mediaUrl"
        static let mediaHeight = "mediaHeight"
        static let amount = "amount"
        /// 原生目标路径 与 targetUrl 互斥
        static let targetPage = "targetPage"
        /// H5目标路径 与 targetPage 互斥
        static let targetUrl = "targetUrl"
    }
    /// web 传输
    struct Uploader {
        static let bookSupport = ["txt"]
        static let musicSupport = ["mp3"]
        /// 上传位置
        static let uploadDirectory: String = {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).last! + "/QianyuImUploadDirectory")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path) { return path }
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }catch{ }
            return path
        }()
    }
    struct Reader {
        /// 数据库地址
        static let readerPath = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask,true).last! + "/QianyuImReader")
        /// 本地小说存储位置
        static let localBooksPath: String = {
            let path = readerPath + "/QianyuImReaderLocalBooks"
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path) { return path }
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }catch{ }
            return path
        }()
    }
    
}
