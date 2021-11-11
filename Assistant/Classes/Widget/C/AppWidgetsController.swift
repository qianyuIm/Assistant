//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import SnapKit
import JXPagingView
import JXSegmentedView
import RxSwift
import RxCocoa

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

class AppWidgetsController: AppBaseVMController {
    lazy var leftItem: UIBarButtonItem = {
        let titleLabel = UILabel()
        titleLabel.text = R.string.localizable.barWidgetLeftTitle.key.app.localized()
        titleLabel.font = QYFont.fontMedium(26)
        let item = UIBarButtonItem(customView: titleLabel)
        return item
    }()
    lazy var rightItem: UIBarButtonItem = {
        let userView = AppUserWidgetView.create()
        let item = UIBarButtonItem(customView: userView)
        return item
    }()
    lazy var pagingView: JXPagingView = {
        let pagingView = JXPagingView(delegate: self, listContainerType: .collectionView)
        pagingView.automaticallyDisplayListVerticalScrollIndicator = false
        pagingView.listContainerView.scrollView.emptyDataSetSource = self
        pagingView.listContainerView.scrollView.emptyDataSetDelegate = self
        return pagingView
    }()
    lazy var headerView: WidgetHeaderView = {
        let headerView = WidgetHeaderView()
        return headerView
    }()
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        return segmentedView
    }()
    lazy var dataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = []
        dataSource.itemSpacing = QYInch.value(20)
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = true
        return dataSource
    }()
    lazy var indicator: JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        indicator.lineStyle = .lengthenOffset
        return indicator
    }()
    var dataSections: [AppWidgetSection]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func setupUI() {
        super.setupUI()
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
        view.addSubview(pagingView)
        segmentedView.dataSource = dataSource
        segmentedView.indicators = [indicator]
        segmentedView.listContainer = pagingView.listContainerView
        
    }
    override func setupConstraints() {
        super.setupConstraints()
        pagingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        segmentedView.theme.backgroundColor = appThemeProvider.attribute({ $0.backgroundColor
        })
        appThemeProvider.typeStream.subscribe (onNext: { [weak self] themeProvider in
            let segmentedTheme = themeProvider.associatedObject.segmentedTheme
            self?.dataSource.titleNormalColor = segmentedTheme.titleNormalColor
            self?.dataSource.titleSelectedColor = segmentedTheme.titleSelectedColor
            self?.dataSource.titleNormalFont = segmentedTheme.titleNormalFont
            self?.dataSource.titleSelectedFont = segmentedTheme.titleSelectedFont
            self?.indicator.indicatorColor = segmentedTheme.indicatorColor
            self?.segmentedView.reloadDataWithoutListContainer()
        }).disposed(by: rx.disposeBag)
    }
    
    override func setupLanguage() {
        super.setupLanguage()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppWidgetsViewModel else {
            return
        }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = AppWidgetsViewModel.Input(trigger: trigger)
        let output = viewModel.transform(input: input)
        
        output.headerDataSource.subscribe (onNext: {[weak self] headerSections in
            self?.reloadHeaderView(headerSections)
        }).disposed(by: rx.disposeBag)
        
        output.dataSource.subscribe (onNext: { [weak self] widgetSection in
            self?.reloadPageView(widgetSection)
        }).disposed(by: rx.disposeBag)
    }
    
}
extension AppWidgetsController {
    func reloadHeaderView(_ headerSource: [WidgetHeaderSection]) {
        headerView.dataSource.accept(headerSource)
    }
    func reloadPageView(_ sections: [AppWidgetSection]) {
        self.dataSections = sections
        let titles = sections.compactMap { $0.title }
        dataSource.titles = titles
        dataSource.reloadData(selectedIndex: 0)
        segmentedView.defaultSelectedIndex = 0
        segmentedView.reloadDataWithoutListContainer()
        pagingView.reloadData()
    }
}

extension AppWidgetsController: JXPagingViewDelegate {
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return headerView.viewHeight()
    }
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return headerView
    }
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return Int(QYInch.value(48))
    }
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return dataSource.dataSource.count
    }
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let section = self.dataSections![index]
        switch section {
        case .small:
            let smallViewModel = SmallWidgetViewModel()
            return SmallWidgetController(viewModel: smallViewModel)
        case .medium:
            let smallViewModel = SmallWidgetViewModel()
            return SmallWidgetController(viewModel: smallViewModel)
        case .large:
            let smallViewModel = SmallWidgetViewModel()
            return SmallWidgetController(viewModel: smallViewModel)

        }
    }
}
