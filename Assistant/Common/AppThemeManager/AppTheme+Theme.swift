//
//  AppTheme+Theme.swift
//  ios_app
//
//  Created by cyd on 2021/10/29.
//

import ESTabBarController_swift
import RxSwift
import RxCocoa
import RxTheme
//import FSPagerView
//
//extension ThemeProxy where Base: ESTabBarItemContentView {
//    var iconColor: ThemeAttribute<UIColor> {
//        get { fatalError("set only") }
//        set {
//            base.iconColor = newValue.value
//            let disposable = newValue.stream
//                .take(until: base.rx.deallocating)
//                .observe(on: MainScheduler.instance)
//                .bind(to: base.rx.iconColor)
//            hold(disposable, for: "iconColor")
//        }
//    }
//    var textColor: ThemeAttribute<UIColor> {
//        get { fatalError("set only") }
//        set {
//            base.textColor = newValue.value
//            let disposable = newValue.stream
//                .take(until: base.rx.deallocating)
//                .observe(on: MainScheduler.instance)
//                .bind(to: base.rx.textColor)
//            hold(disposable, for: "textColor")
//        }
//    }
//    var highlightTextColor: ThemeAttribute<UIColor> {
//        get { fatalError("set only") }
//        set {
//            base.highlightTextColor = newValue.value
//            let disposable = newValue.stream
//                .take(until: base.rx.deallocating)
//                .observe(on: MainScheduler.instance)
//                .bind(to: base.rx.highlightTextColor)
//            hold(disposable, for: "highlightTextColor")
//        }
//    }
//    var highlightIconColor: ThemeAttribute<UIColor> {
//        get { fatalError("set only") }
//        set {
//            base.highlightIconColor = newValue.value
//            let disposable = newValue.stream
//                .take(until: base.rx.deallocating)
//                .observe(on: MainScheduler.instance)
//                .bind(to: base.rx.highlightIconColor)
//            hold(disposable, for: "highlightIconColor")
//        }
//    }
//}
extension ThemeProxy where Base: UIApplication {
    var statusBarStyle: ThemeAttribute<UIStatusBarStyle> {
        get { fatalError("set only") }
        set {
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.statusBarStyle)
            hold(disposable, for: "statusBarStyle")
        }
    }
}

//extension ThemeProxy where Base: FSPageControl {
//    
//    func fillColor(from newValue: ThemeAttribute<UIColor?>, for state: UIControl.State) {
//        base.setFillColor(newValue.value, for: state)
//        let disposable = newValue.stream
//            .take(until: base.rx.deallocating)
//            .observe(on: MainScheduler.instance)
//            .bind(to: base.rx.fillColor(for: state))
//        hold(disposable, for: "fillColor.forState.\(state.rawValue)")
//    }
//}
