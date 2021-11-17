//
//  Observable+Operators.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return `catch` { _ in
            return Observable.empty()
        }
    }
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    func mapTo<R>(_ value: R) -> Observable<R> {
        return map { _ in value }
    }
}

extension SharedSequenceConvertibleType {

    func mapTo<R>(_ value: R) -> SharedSequence<SharingStrategy, R> {
        return map { _ in value }
    }

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
