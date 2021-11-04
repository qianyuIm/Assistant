//
//  MusicResponseHandle.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Moya
/// 用于 musicApi返回数据的处理协议
protocol MusicResponseHandle: CustomMoyaResponseable {}

extension MusicResponseHandle {
    func isServerSuccess(response: Response) -> Bool {
//        if let result = try? response.mapMusicObject(MusicBaseModel.self) {
//            return result.code == 200
//        }
        return false
    }
    
}
