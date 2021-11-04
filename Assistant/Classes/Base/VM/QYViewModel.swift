//
//  QYViewModel.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import RxActivityIndicator
import Moya
import NSObject_Rx
import RxSwift
import RxCocoa

protocol QYViewModelable {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class QYViewModel {
    let loading = ActivityIndicator()
    let error = ErrorTracker()
    /// 全部自定义的error
    let errorWrap = BehaviorRelay<MoyaErrorWrap>(value: MoyaErrorWrap.data)
    required init() {
        
        error.asObservable().compactMap { (error)  -> MoyaErrorWrap? in
            if let errorResponse = error as? MoyaError {
                return errorResponse.asMoyaErrorWrap()
            } else {
                return nil
            }
        }.bind(to: errorWrap).disposed(by: rx.disposeBag)
        
    }
}
extension QYViewModel: HasDisposeBag, ReactiveCompatible {}

