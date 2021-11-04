//
//  AppUtility+Json.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import Foundation
extension AppUtility {
    /// 返回本地数据
    /// - Parameter file: 本地文件名
    /// - Returns:
    class func localJsonData(for file: String) -> Data {
        let jsonPath = Bundle.main.path(forResource: file, ofType: "json")
        let jsonUrl = URL(fileURLWithPath: jsonPath!)
        let data = try? Data(contentsOf: jsonUrl)
        return data ?? "".data(using: String.Encoding.utf8)!
    }
}
