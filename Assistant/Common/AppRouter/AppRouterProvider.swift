//
//  AppRouterProvider.swift
//  ios_app
//
//  Created by cyd on 2021/10/20.
//

import Foundation
import URLNavigator

protocol AppRouterTypeable: CaseIterable  {
    /// 模板 用于注册 例如: xxx://open/<path:_>
    var pattern: String { get }
    /// 需要打开的控制器
    ///
    /// - Parameters:
    ///   - url: url
    ///   - values: 参数值
    /// - Returns: 实现了 Routerable 协议的视图控制器 如果返回为空则会调用下面打开处理方法
    func controller(url: URLConvertible,
                    values: [String: Any],
                    context: AppRouterContext?) -> AppRouterable?
    /// 打开处理 (当无控制器时执行)
    ///
    /// - Parameters:
    ///   - url: url
    ///   - values: 参数值
    ///   - completion: 处理完成结果回调 *必须调用
    func handle(url: URLConvertible,
                values: [String: Any],
                context: AppRouterContext?)
}

protocol AppRouterable: UIViewController {
    
    /// 打开 默认是push
    ///
    /// - Parameter completion: 打开完成回调
    func routerOpen(with completion: (() -> Void)?)
    
    /// 关闭
    ///
    /// - Parameters:
    ///   - completion: 关闭完成回调
    func routerClose(with completion: (() -> Void)?)
}

class AppRouterProvider<T: AppRouterTypeable> {
    
    typealias ViewControllerFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: AppRouterContext?) -> AppRouterable?
    
    typealias URLOpenHandlerFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: AppRouterContext?) -> Bool
    
    private let navigator: Navigator
    private let plugins: [AppRouterPlugin<T>]
    
    public init(navigator: Navigator = Navigator(), _ plugins: [AppRouterPlugin<T>]) {
        self.navigator = navigator
        self.plugins = plugins
        
        // 注册处理
        T.allCases.forEach { registers($0) }
    }
    
}
extension AppRouterProvider {
    /// 获取视图控制器
    ///
    /// - Parameters:
    ///   - url: url
    ///   - context: context
    /// - Returns: 视图控制器
    public func viewController(_ url: URLConvertible, _ context: AppRouterContext? = nil) -> AppRouterable? {
        return navigator.viewController(for: url, context: context) as? AppRouterable
    }
    /// 打开
    ///
    /// - Parameters:
    ///   - url: url
    ///   - completion: 打开完成回调
    /// - Returns: true or false
    @discardableResult
    public func open(_ url: URLConvertible,
                     context: AppRouterContext? = nil) -> Bool {
        return navigator.open(url, context: context)
    }
}
private extension AppRouterProvider {
    /// 注册
    func registers(_ type: T) {
        
        self.register(type) { url, values, context in
            return type.controller(url: url, values: values, context: context)
        }
        self.handle(type) { [weak self] url, values, context in
            guard let strongSelf = self else { return false }
            if strongSelf.plugins.isEmpty {
                if let controller = strongSelf.viewController(url, context) {
                    controller.routerOpen {}
                } else {
                    type.handle(url: url, values: values,context: context)
                }
            } else {
                guard strongSelf.plugins.contains(where: { $0.should(open: type) }) else {
                    return false
                }
                var result = true
                let total = strongSelf.plugins.count
                var count = 0
                let group = DispatchGroup()
                strongSelf.plugins.forEach { p in
                    group.enter()
                    p.prepare(open: type) {
                        // 防止插件多次回调
                        defer { count += 1 }
                        guard count < total else { return }
                        
                        result = $0 ? result : false
                        group.leave()
                    }
                }
                group.notify(queue: .main) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    guard result else {
                        return
                    }
                    if let controller = self.viewController(url, context) {
                        self.plugins.forEach {
                            $0.will(open: type, controller: controller)
                        }
                        controller.routerOpen { [weak self] in
                            guard let self = self else { return }
                            self.plugins.forEach {
                                $0.did(open: type, controller: controller)
                            }
                        }
                    } else {
                        type.handle(url: url, values: values, context: context)
                    }
                }
            }
            return true
        }
    }
    func register(_ url: T, _ factory: @escaping ViewControllerFactory) {
        navigator.register(url.pattern) { (url, values, context) -> UIViewController? in
            return factory(url, values, context as? AppRouterContext)
        }
    }
    func handle(_ url: T, _ factory: @escaping URLOpenHandlerFactory) {
        navigator.handle(url.pattern) { (url, values, context) -> Bool in
            return factory(url, values, context as? AppRouterContext)
        }
    }
}
