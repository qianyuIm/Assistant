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
import Schedule
import SwiftDate
import AttributedString

private let kSupplementaryHeaderKind = "small-header-element-kind"

class SmallWidgetController: AppBaseCollectionVMController {

    var listViewDidScrollCallback: ((UIScrollView) -> Void)?
    var timer: Schedule.Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }
    override func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(QYInch.Widget.smallSize.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(QYInch.Widget.smallSize.width),
                                              heightDimension: .estimated(QYInch.Widget.smallSize.height))
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
        collectionView.app.register(cellClass: SmallWidgetFlipClockCell.self)
        collectionView.app.register(nibWithViewClass: AppWidgetHeaderSupplementaryView.self, forSupplementaryViewElementOfKind: kSupplementaryHeaderKind)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupTimer() {
        let plan = Plan.every(1.seconds)
        self.timer = plan.do(queue: .main) {
            self.timerUpdate()
        }
    }

    func timerUpdate() {
        guard let viewModel = viewModel as? SmallWidgetViewModel else { return  }
        guard let dataSource = viewModel.dataSource else { return }
        for visibleCell in self.collectionView.visibleCells {
            if let indexPath = self.collectionView.indexPath(for: visibleCell) {
                let section = dataSource[indexPath.section]
                let item = section.items[indexPath.item]
                switch item {
                case .flipClockItem(let attributes):
                    (visibleCell as? SmallWidgetFlipClockCell)?.config(with: attributes)
                }
            }
        }
    }
}
extension SmallWidgetController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}
extension SmallWidgetController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel as? SmallWidgetViewModel else { return 0 }
        guard let dataSource = viewModel.dataSource else { return 0 }
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? SmallWidgetViewModel else { return 0 }
        guard let dataSource = viewModel.dataSource else { return 0 }
        let section = dataSource[section]
        return section.items.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.app.dequeueReusableSupplementaryView(ofKind: kind, withClass: AppWidgetHeaderSupplementaryView.self, for: indexPath)
        if let viewModel = viewModel as? SmallWidgetViewModel, let dataSource = viewModel.dataSource {
            let section = dataSource[indexPath.section]
            supplementaryView.config(supplementary: section.supplementary)
        }
        return  supplementaryView
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.app.dequeueReusableCell(cellClass: UICollectionViewCell.self, for: indexPath)
        guard let viewModel = viewModel as? SmallWidgetViewModel else { return cell }
        guard let dataSource = viewModel.dataSource else { return cell }
        let section = dataSource[indexPath.section]
        let item = section.items[indexPath.item]
        switch item {
        case .flipClockItem(let attributes):
            let cell = collectionView.app.dequeueReusableCell(cellClass: SmallWidgetFlipClockCell.self, for: indexPath)
            cell.config(with: attributes)
            return cell
        }
    }   
}
// MARK: - JXPagingViewListViewDelegate
extension SmallWidgetController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return view
    }

    func listScrollView() -> UIScrollView {
        return collectionView
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> Void) {
        self.listViewDidScrollCallback = callback
    }
    func listWillAppear() {
        self.timer?.resume()
    }
    func listWillDisappear() {
        self.timer?.suspend()
    }

}
