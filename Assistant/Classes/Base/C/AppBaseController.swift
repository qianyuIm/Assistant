//
//  QYBaseController.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import RxTheme

class AppBaseController: UIViewController, AppRouterable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _prepare()
        _registerNotification()
        _setupUI()
        _setupConstraints()
        _setupTheme()
    }
    
    /// 1. 常量设置
    func _prepare() {
        
    }
    /// 2. 通知
    func _registerNotification() {}
    /// 3. UI设置
    func _setupUI() { }
    /// 4. 约束设置
    func _setupConstraints() {}
    /// 5. 皮肤设置
    func _setupTheme() {
        view.theme.backgroundColor = appThemeProvider.attribute { $0.backgroundColor }

        UIApplication.shared.theme.statusBarStyle = appThemeProvider.attribute { $0.statusBarStyle }
        
        appThemeProvider.typeStream.subscribe(onNext: { [weak self](theme) in
            guard let strongSelf = self else { return }
            /// 需要异步执行
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
//                strongSelf.hbd_setNeedsUpdateNavigationBar()
//            })
            DispatchQueue.main.async {
                strongSelf.hbd_setNeedsUpdateNavigationBar()
            }
        }).disposed(by: rx.disposeBag)
       
    }
    //MARK: -- AppRouterable
    func routerOpen(with completion: (() -> Void)?) {
        guard let controller = UIViewController.topMost else {
            return
        }
        if let navigation = controller as? UINavigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigation.pushViewController(self, animated: true)
            CATransaction.commit()
            
        } else if let navigation = controller.navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigation.pushViewController(self, animated: true)
            CATransaction.commit()
            
        } else {
            let navigation = UINavigationController(rootViewController: self)
            controller.present(navigation, animated: true, completion: completion)
        }
    }
    
    func routerClose(with completion: (() -> Void)?) {
        guard
            let navigation = navigationController,
            navigation.viewControllers.first != self else {
            let presenting = presentingViewController ?? self
            presenting.dismiss(animated: true, completion: completion)
            return
        }
        guard presentedViewController == nil else {
            dismiss(animated: true) { [weak self] in self?.routerClose(with: completion) }
            return
        }
        
        func parents(_ controller: UIViewController) -> [UIViewController] {
            guard let parent = controller.parent else {
                return [controller]
            }
            return [controller] + parents(parent)
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        if let top = navigation.topViewController, parents(self).contains(top) {
            navigation.popViewController(animated: true)
        } else {
            let temp = navigation.viewControllers.filter { !parents(self).contains($0) }
            navigation.setViewControllers(temp, animated: true)
        }
        CATransaction.commit()
    }
    
    deinit {
        QYLogger.debug("\(self) 移除了")
    }
    
}

