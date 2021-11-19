//
//  AppUtility+File.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//

import Foundation

extension AppUtility {
    /// 生成不重复的文件路径
    /// - Parameters:
    ///   - directory: 目录
    ///   - fileName: 文件名
    /// - Returns: (文件路径, 标号)
    class func generate(directory: String,
                        fileName: String,
                        retries: Int = 1) -> (String, Int) {
        var generate = directory + "/" + fileName
        var retries = retries
        if FileManager.default.fileExists(atPath: generate) {
            let pathExtension = fileName.app.pathExtension
            let base = fileName.app.deletingPathExtension
            repeat {
                retries += 1
                if pathExtension.isEmpty {
                    generate = directory + "/" + "\(base)(\(retries))"
                } else {
                    generate = directory + "/" + "\(base)(\(retries)).\(pathExtension)"
                }
            } while FileManager.default.fileExists(atPath: generate)
            return (generate, retries)
        }
        return (generate, retries)
    }
    /// 全部子目录 单层可以使用  多层比较浪费 最好使用其他方式
    /// - Parameter atPath:
    /// - Returns:
    class func subpaths(atPath: String) -> [String]? {
        return FileManager.default.subpaths(atPath: atPath)
    }
}
