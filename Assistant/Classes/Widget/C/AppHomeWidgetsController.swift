//
//  AppHomeWidgetsController.swift
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

class AppHomeWidgetsController: AppBaseVMController {
    lazy var leftItemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = QYFont.fontMedium(26)
        return label
    }()
    lazy var leftItem: UIBarButtonItem = {
        let item = UIBarButtonItem(customView: leftItemTitleLabel)
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
    var dataSections: [AppHomeWidgetSection]?
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
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(-QYInch.tabbarHeight)
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        leftItemTitleLabel.theme.textColor = appThemeProvider.attribute({ $0.primaryColor
        })
        segmentedView.theme.backgroundColor = appThemeProvider.attribute({ $0.backgroundColor
        })
        pagingView.theme.backgroundColor = appThemeProvider.attribute({ $0.backgroundColor
        })
        pagingView.mainTableView.theme.backgroundColor = appThemeProvider.attribute({ $0.backgroundColor
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
        leftItemTitleLabel.text = R.string.localizable.barWidgetLeftTitle.key.app.localized()

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppHomeWidgetsViewModel else {
            return
        }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = AppHomeWidgetsViewModel.Input(trigger: trigger)
        let output = viewModel.transform(input: input)
        
        output.headerDataSource.subscribe (onNext: {[weak self] headerSections in
            self?.reloadHeaderView(headerSections)
        }).disposed(by: rx.disposeBag)
        
        output.dataSource.subscribe (onNext: { [weak self] widgetSection in
            self?.reloadPageView(widgetSection)
        }).disposed(by: rx.disposeBag)
        
        
    }
    
}
extension AppHomeWidgetsController {
    func reloadHeaderView(_ headerSource: [WidgetHeaderSection]) {
        headerView.dataSource.accept(headerSource)
    }
    func reloadPageView(_ sections: [AppHomeWidgetSection]) {
        self.dataSections = sections
        let titles = sections.compactMap { $0.title }
        dataSource.titles = titles
        dataSource.reloadData(selectedIndex: 0)
        segmentedView.defaultSelectedIndex = 0
        segmentedView.reloadDataWithoutListContainer()
        pagingView.reloadData()
    }
}

extension AppHomeWidgetsController: JXPagingViewDelegate {
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
            let mediumViewModel = MediumWidgetViewModel()
            return MediumWidgetController(viewModel: mediumViewModel)
        case .large:
            let largeiewModel = LargeWidgetViewModel()
            return LargeWidgetController(viewModel: largeiewModel)
        }
    }
}
