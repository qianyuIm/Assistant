//
//  ResponseHandle.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Moya

typealias CustomTargetType = CustomMoyaResponseable & TargetType

protocol CustomMoyaResponseable {
    /// 判断服务端返回数据是否符合规范，一般为判断返回json的code是否为200
    func isServerSuccess(response: Moya.Response) -> Bool
}

extension CustomMoyaResponseable {
    func isServerSuccess(response: Moya.Response) -> Bool {
        true
    }
}
