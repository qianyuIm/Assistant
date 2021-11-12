//
//  MyWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/12.
//

import UIKit
import JXSegmentedView
import RxCocoa
import RxSwift
class MyWidgetsController: AppBaseVMController {
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: 200, height: 34))
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        segmentedView.app.addRoundCorners(.allCorners, radius: 17)
        segmentedView.layer.borderWidth = QYInch.singleLineHeight
        return segmentedView
    }()
    lazy var dataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = []
        dataSource.itemSpacing = QYInch.value(20)
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
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    var dataSections: [AppWidgetSection]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare() {
        super.prepare()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func setupUI() {
        super.setupUI()
        self.hbd_barAlpha = 0
        self.hbd_backInteractive = false
        segmentedView.indicators = [indicator]
        segmentedView.dataSource = dataSource
        navigationItem.titleView = segmentedView
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        listContainerView.snp.makeConstraints { (make) in
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
            self?.segmentedView.layer.borderColor = segmentedTheme.indicatorColor.cgColor
            self?.segmentedView.reloadDataWithoutListContainer()
        }).disposed(by: rx.disposeBag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? MyWidgetsViewModel else {
            return
        }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = MyWidgetsViewModel.Input(trigger: trigger)
        let output = viewModel.transform(input: input)
        output.dataSource.subscribe (onNext: { [weak self] widgetSection in
            self?.reloadSegmentedView(widgetSection)
        }).disposed(by: rx.disposeBag)
        
    }

}
extension MyWidgetsController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MyWidgetsController {
    func reloadSegmentedView(_ sections: [AppWidgetSection]) {
        self.dataSections = sections
        let titles = sections.compactMap { $0.title }
        dataSource.titles = titles
        segmentedView.reloadData()
    }
}
extension MyWidgetsController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}
extension MyWidgetsController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.dataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let section = self.dataSections![index]
        switch section {
        case .small:
            let smallViewModel = MySmallWidgetViewModel()
            return MySmallWidgetController(viewModel: smallViewModel)
        case .medium:
            let smallViewModel = MySmallWidgetViewModel()
            return MySmallWidgetController(viewModel: smallViewModel)
        case .large:
            let smallViewModel = MySmallWidgetViewModel()
            return MySmallWidgetController(viewModel: smallViewModel)
        }
    }
    
    
}
