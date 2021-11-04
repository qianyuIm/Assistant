//
//  MJRefreshComponent+Rx.swift
//  QYRepository
//
//  Created by cyd on 2020/5/13.
//  Copyright © 2020 qianyuIm. All rights reserved.
//

import class MJRefresh.MJRefreshComponent
import RxCocoa
import RxSwift

extension Reactive where Base: MJRefreshComponent {
    
    var refreshing: ControlEvent<Void> {
        let source = Observable<Void>.create { [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
}
