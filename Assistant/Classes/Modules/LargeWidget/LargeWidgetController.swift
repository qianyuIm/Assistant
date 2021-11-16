//
//  SmallWidgetController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit
import JXPagingView
import RxSwift
import RxCocoa
import RxDataSources

private let kSupplementaryHeaderKind = "resource-header-element-kind"

class LargeWidgetController: AppBaseCollectionVMController {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<LargeWidgetSection> = {
        return RxCollectionViewSectionedReloadDataSource<LargeWidgetSection> { dataSource, collectionView, indexPath, item in
            switch item {
            case .flipClockItem(let attributes):
                let cell = collectionView.app.dequeueReusableCell(cellClass: LargeWidgetFlipClockCell.self, for: indexPath)
                cell.config(with: attributes)
                return cell
                
            }
        } configureSupplementaryView: { dataSource, collectionView, elementKind, indexPath in
            let section = dataSource[indexPath.section]
            let supplementaryView = collectionView.app.dequeueReusableSupplementaryView(ofKind: elementKind, withClass: AppWidgetHeaderSupplementaryView.self, for: indexPath)
            supplementaryView.config(supplementary: section.supplementary)
            return supplementaryView
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(QYInch.Widget.largeAspectRatioSize.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(QYInch.Widget.largeAspectRatioSize.width),
                                               heightDimension: .estimated(QYInch.Widget.largeAspectRatioSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let supplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: supplementarySize,
            elementKind: kSupplementaryHeaderKind,
            alignment: .top)
        section.boundarySupplementaryItems = [supplementary]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func setupUI() {
        super.setupUI()
        collectionView.app.register(cellClass: LargeWidgetFlipClockCell.self)
        collectionView.app.register(nibWithViewClass: AppWidgetHeaderSupplementaryView.self, forSupplementaryViewElementOfKind: kSupplementaryHeaderKind)
        
        collectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? LargeWidgetViewModel else {
            return
        }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = LargeWidgetViewModel.Input(trigger: trigger)
        let output = viewModel.transform(input: input)
        output.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
    
}

//MARK: JXPagingViewListViewDelegate
extension LargeWidgetController: UIScrollViewDelegate, JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return view
    }
    
    func listScrollView() -> UIScrollView {
        return collectionView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
    
}
