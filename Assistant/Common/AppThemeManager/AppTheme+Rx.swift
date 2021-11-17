//
//  AppTheme+Rx.swift
//  ios_app
//
//  Created by cyd on 2021/10/29.
//

import Foundation
import RxCocoa
import RxSwift
// import FSPagerView
extension Reactive where Base: UIApplication {
    var statusBarStyle: Binder<UIStatusBarStyle> {
        return Binder(self.base) { view, attr in
            globalStatusBarStyle.accept(attr)
        }
    }
}
// extension Reactive where Base: FSPageControl {
//    
//    func fillColor(for state: UIControl.State) -> Binder<UIColor?>  {
//        return Binder(self.base) { view, attr in
//            view.setFillColor(attr, for: state)
//        }
//    }
// }
