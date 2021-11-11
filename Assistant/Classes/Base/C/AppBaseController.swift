//
//  QYBaseController.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import RxTheme
import Localize_Swift

class AppBaseController: UIViewController, AppRouterable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        registerNotification()
        setupUI()
        setupConstraints()
        setupTheme()
        setupLanguage()
    }
    
    /// 1. 常量设置
    func prepare() {}
    /// 2. 通知
    func registerNotification() {
        NotificationCenter.Languageau.add(.LCLLanguageChangeNotification, observer: self, selector: #selector(setupLanguage), object: nil)
    }
    /// 3. UI设置
    func setupUI() { }
    /// 4. 约束设置
    func setupConstraints() {}
    /// 5. 皮肤设置
    func setupTheme() {
        view.theme.backgroundColor = appThemeProvider.attribute { $0.backgroundColor }

        UIApplication.shared.theme.statusBarStyle = appThemeProvider.attribute { $0.statusBarStyle }
        
        appThemeProvider.typeStream.subscribe(onNext: { [weak self](theme) in
            guard let strongSelf = self else { return }
            
            /// 需要异步执行
            DispatchQueue.main.async {
                strongSelf.setNeedsStatusBarAppearanceUpdate()
                strongSelf.hbd_setNeedsUpdateNavigationBar()
            }
        }).disposed(by: rx.disposeBag)
       
    }
    /// 6. 语言设置
    @objc func setupLanguage() {
        QYLogger.debug("改变")
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

