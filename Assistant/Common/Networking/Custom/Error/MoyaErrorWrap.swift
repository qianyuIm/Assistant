//
//  MoyaErrorWrap.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Foundation
import Moya
import Localize_Swift


extension MoyaError {
    func asMoyaErrorWrap() -> MoyaErrorWrap? {
        switch self {
        case .jsonMapping(let response):
            let statusCode = response.statusCode
            if (statusCode != 200) {
                if (statusCode == 301) {
                    return MoyaErrorWrap.unauthorized
                } else if (statusCode == 404) {
                    return MoyaErrorWrap.error404
                }
            }
            return MoyaErrorWrap.json
        case .underlying:
            return MoyaErrorWrap.unNetwork
        default:
            return MoyaErrorWrap.data
        }
    }
}

struct MoyaErrorWrap: Error {
    let code: Int
    let title: String
    let detail: String
    
    init(code: Int = 0, title: String, detail: String) {
        self.code = code
        self.title = title
        self.detail = detail
    }
    
    /// 数据
    static var data = MoyaErrorWrap(code: -10001,
                                    title: R.string.localizable.emptyDataTitle.key.localized(),
                                    detail: R.string.localizable.emptyDataDetail.key.localized())
    /// 无网络
    static var unNetwork = MoyaErrorWrap(code: -10002,
                                         title: R.string.localizable.emptyUnConnectedTitle.key.localized(),
                                         detail: R.string.localizable.emptyUnConnectedDetail.key.localized())
    /// json错误
    static var json = MoyaErrorWrap(code: -10003,
                                    title: R.string.localizable.emptyJsonTitle.key.localized(),
                                    detail: R.string.localizable.emptyJsonDetail.key.localized())
    /// 未授权需要登录
    static var unauthorized = MoyaErrorWrap(code: 301,
                                            title: R.string.localizable.emptyAuthorizationTitle.key.localized(),
                                            detail: R.string.localizable.emptyAuthorizationDetail.key.localized())
    /// 404
    static var error404 = MoyaErrorWrap(code: 404,
                                        title: R.string.localizable.empty404Title.key.localized(),
                                        detail: R.string.localizable.empty404Detail.key.localized())
    
    
}
extension MoyaErrorWrap: Equatable {
    public static func ==(lhs: MoyaErrorWrap, rhs: MoyaErrorWrap) -> Bool {
        lhs.code == rhs.code
    }
}
