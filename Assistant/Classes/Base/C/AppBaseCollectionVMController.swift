//
//  QYBaseCollectionVMController.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit
import EmptyDataSet_Swift
import RxCocoa
import RxSwift


class AppBaseCollectionVMController: AppBaseVMController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.alwaysBounceVertical = true
        collectionView.app.register(cellClass: UICollectionViewCell.self)
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
    override func setupUI() {
        super.setupUI()
        view.addSubview(collectionView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        collectionView.theme.backgroundColor = appThemeProvider.attribute { $0.backgroundColor }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard viewModel != nil else {
            return
        }
        let loading = isLoading
            .distinctUntilChanged()
            .mapToVoid()
        
        let network = QYReachability.shared.reachabilityConnection
            .skip(1)
            .distinctUntilChanged()
            .mapToVoid()
        
        Observable.of(loading,network)
            .merge()
            .bind(to: collectionView.rx.reloadEmptyData)
            .disposed(by: rx.disposeBag)
        
        bindHeader()
        bindFooter()
        
    }
    
}

private extension AppBaseCollectionVMController {
    
    // MARK: - 绑定头部刷新回调和头部刷新状态
    private func bindHeader() {
        guard let refreshHeader = collectionView.mj_header,
              let viewModel = viewModel as? AppRefreshViewModel else { return }
        // 将刷新事件传递给 refreshVM
        refreshHeader.rx.refreshing
            .bind(to: viewModel.refreshInput.beginHeaderRefresh)
            .disposed(by: rx.disposeBag)
        
        // 头部状态
        viewModel
            .refreshOutput
            .headerRefreshState
            .drive(refreshHeader.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 失败时的头部状态
        viewModel
            .error
            .mapTo(false)
            .drive(refreshHeader.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
    }
    // MARK: - 绑定尾部刷新回调和尾部刷新状态
    private func bindFooter() {
        guard let refreshFooter = collectionView.mj_footer,
              let viewModel = viewModel as? AppRefreshViewModel else { return }
        // 将刷新事件传递给 refreshVM
        refreshFooter.rx.refreshing
            .bind(to: viewModel.refreshInput.beginFooterRefresh)
            .disposed(by: rx.disposeBag)
        
        // 尾部状态
        viewModel
            .refreshOutput
            .footerRefreshState
            .drive(refreshFooter.rx.refreshFooterState)
            .disposed(by: rx.disposeBag)
        
        // 失败时的尾部状态
        viewModel
            .error
            .map { [weak self] _ -> RxMJRefreshFooterState in
                guard let self = self else { return .hidden }
                return (self.collectionView.mj_totalDataCount() == 0) ? .hidden : .default
            }
            .drive(refreshFooter.rx.refreshFooterState)
            .disposed(by: rx.disposeBag)
        
    }
}
