//
//  CustomResponsePlugin.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Foundation
import Moya

struct CustomResponsePlugin: PluginType {
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        guard let customTarget = asCustomTargetType(target) else {
            return result
        }
        switch result {
        case let .success(response):
            // 服务端返回的数据是否符合成功约定
            if customTarget.isServerSuccess(response: response) {
                return result
            }
            // 不符合成功约定，直接返回json解析异常错误
            return .failure(.jsonMapping(response))
        case .failure:
            return result
        }
    }
    private func asCustomTargetType(_ target: TargetType) -> CustomTargetType? {
        // 如果是 MultiTarget，则取出真实的 TargetType
        if let multiTarget = target as? Moya.MultiTarget {
            return multiTarget.target as? CustomTargetType
        }
        return target as? CustomTargetType
    }
}
