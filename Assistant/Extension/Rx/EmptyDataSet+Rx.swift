//
//  UIScrollView+Rx.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import Foundation
import EmptyDataSet_Swift
import RxSwift
import RxCocoa

// MARK: - EmptyDataSet
extension Reactive where Base: UIScrollView {
    /// 刷新空白页面
    var reloadEmptyData: Binder<Void> {
        return Binder(base) { (this, _) in
            this.reloadEmptyDataSet()
        }
    }
}

