//
//  QYBaseVMController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import NSObject_Rx
import SwiftRichString
import EmptyDataSet_Swift
import RxSwift
import RxCocoa

class AppBaseVMController: AppBaseController {
    var viewModel: AppViewModel?
    var context: AppRouterContext?
    init(viewModel: AppViewModel?,
         context: AppRouterContext? = nil ) {
        self.viewModel = viewModel
        self.context = nil
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 是否在加载
    let isLoading = BehaviorRelay(value: false)
    /// 语言设置
    let languageChanged = BehaviorRelay<Void>(value: ())

    /// 网络重试
    let requestRetry = PublishSubject<Void>()
    /// 数据为空点击事件
    let emptyDataDidTap = PublishSubject<Void>()
    /// 数据为空 - 网络未连接 是否允许滚动
    var emptyUnConnectionShouldAllowScroll: Bool = false
    /// 数据为空 -  是否允许滚动
    var emptyShouldAllowScroll: Bool = true
    /// 数据为空 - 网络未连接图片
    var emptyUnConnectionImage: UIImage?
    /// 数据为空 - 图片
    var emptyImage: UIImage?
    /// 数据为空 - 网络未连接 title
    var emptyUnConnectionTitle: NSAttributedString?
    /// 数据为空 -  title
    var emptyTitle: NSAttributedString?
    /// 数据为空 - 网络未连接 detail
    var emptyUnConnectionDetail: NSAttributedString?
    /// 数据为空 -  detail
    var emptyDetail: NSAttributedString?
    /// 数据为空
    var verticalOffset: CGFloat = 0
    /// 刷新头部
    lazy var refreshHeader: QYRefreshHeader = {
        return QYRefreshHeader()
    }()
    /// 刷新尾部
    lazy var refreshFooter: QYRefreshFooter = {
        return QYRefreshFooter()
    }()
    ///  数据为空 默认文本
    let emptyTitleStyle = Style {
        $0.font = QYFont.fontSemibold(16)
        $0.color = UIColor.app.color(hexString: "#768087")
    }
    ///  数据为空 默认文本
    let emptyDetailStyle = Style {
        $0.font = QYFont.fontRegular(12)
        $0.color = UIColor.app.color(hexString: "#B9C3C9")
    }
    lazy var baseEmptyView: AppBaseEmptyView = {
        // 防止约束冲突的 高度给个大高度
        let emptyView = AppBaseEmptyView(frame: CGRect(x: 0, y: 0, width: QYInch.screenWidth - QYInch.value(40), height: QYInch.value(400)))
        return emptyView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    override func prepare() {
        super.prepare()
        emptyUnConnectionImage = appIconFontIcons.icon_placeholder_unconnected.image(size: QYInch.placeholder, foregroundColor: QYColor.placeholder)
        emptyUnConnectionTitle = R.string.localizable.emptyUnConnectedTitle.key.app.localized().set(style: emptyTitleStyle)
        emptyUnConnectionDetail = R.string.localizable.emptyUnConnectedDetail.key.app.localized().set(style: emptyDetailStyle)
        emptyImage = appIconFontIcons.icon_placeholder_empty.image(size: QYInch.placeholder, foregroundColor: QYColor.placeholder)
        emptyTitle = R.string.localizable.emptyDataTitle.key.app.localized().set(style: emptyTitleStyle)
        emptyDetail = R.string.localizable.emptyDataDetail.key.app.localized().set(style: emptyDetailStyle)
    }
    override func setupLanguage() {
        super.setupLanguage()
        self.languageChanged.accept(())
    }
    func bindViewModel() {
        guard viewModel != nil else {
            return
        }
        viewModel!.loading
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        viewModel?.errorWrap.subscribe(onNext: { [weak self] errorWrap in
            guard let strongSelf = self else { return }
            strongSelf.emptyTitle = errorWrap.title.set(style: strongSelf.emptyTitleStyle)
            strongSelf.emptyDetail = errorWrap.detail.set(style: strongSelf.emptyDetailStyle)
            if errorWrap == MoyaErrorWrap.error404 {
                strongSelf.emptyImage = appIconFontIcons.icon_placeholder_404.image(size: QYInch.placeholder, foregroundColor: QYColor.placeholder)
            } else if errorWrap == MoyaErrorWrap.unauthorized {
                strongSelf.emptyImage = appIconFontIcons.icon_placeholder_unauthorized.image(size: QYInch.placeholder, foregroundColor: QYColor.placeholder)
            }
        }).disposed(by: rx.disposeBag)
        emptyDataDidTap.subscribe(onNext: { [weak self] () in
            guard let strongSelf = self else { return }
            strongSelf.handleEmptyTap()
        }).disposed(by: rx.disposeBag)

    }
    private func handleEmptyTap() {
        if viewModel!.errorWrap.value == MoyaErrorWrap.unauthorized {
            let context = AppRouterContext()
            context.completionHandler = { result in
                guard let result = result else {
                    return
                }
                guard let haveLogin = result[kAppRouterContextLoginResultKey] as? Bool else { return }
                if haveLogin {
                    self.requestRetry.onNext(())
                }
            }
            AppRouter.shared.open(AppRouterType.login.pattern, context: context)
        } else {
            requestRetry.onNext(())
        }
    }
}

extension AppBaseVMController: EmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return !isLoading.value
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        switch QYReachability.shared.connectionValue {
        case .none, .unavailable:
            return emptyUnConnectionShouldAllowScroll
        case .cellular, .wifi:
            return emptyShouldAllowScroll
        }
    }
    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        emptyDataDidTap.onNext(())
    }
}
extension AppBaseVMController: EmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        switch QYReachability.shared.connectionValue {
        case .none, .unavailable:
            baseEmptyView.imageView.image = emptyUnConnectionImage
            baseEmptyView.titleLabel.attributedText = emptyUnConnectionTitle
            baseEmptyView.detailLabel.attributedText = emptyUnConnectionDetail
        case .cellular, .wifi:
            baseEmptyView.imageView.image = emptyImage
            baseEmptyView.titleLabel.attributedText = emptyTitle
            baseEmptyView.detailLabel.attributedText = emptyDetail
        }
        return baseEmptyView
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
}
