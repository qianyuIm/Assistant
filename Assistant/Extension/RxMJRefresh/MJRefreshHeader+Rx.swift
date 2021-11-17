//
//  MJRefreshHeader+Rx.swift
//  RxMJ
//
//  Created by liubo on 2018/9/17.
//

import RxCocoa
import RxSwift
import class MJRefresh.MJRefreshHeader

public extension Reactive where Base: MJRefreshHeader {
    var beginRefreshing: Binder<Void> {
        return Binder(base) { (header, _) in
            header.beginRefreshing()
        }
    }
    var isRefreshing: Binder<Bool> {
        return Binder(base) { header, refresh in
            if refresh && header.isRefreshing {
                return
            } else {
                refresh ? header.beginRefreshing() : header.endRefreshing()
            }
        }
    }
}
