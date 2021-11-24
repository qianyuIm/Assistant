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

private let kSupplementaryHeaderKind = "large-header-element-kind"

class LargeWidgetController: AppBaseCollectionVMController {

    var listViewDidScrollCallback: ((UIScrollView) -> Void)?
    var timer: Schedule.Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
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
        collectionView.app.register(cellClass: LargeWidgetFlowCell.self)
        collectionView.app.register(nibWithViewClass: AppWidgetHeaderSupplementaryView.self, forSupplementaryViewElementOfKind: kSupplementaryHeaderKind)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupTimer() {
        let plan = Plan.every(1.seconds)
        self.timer = plan.do(queue: .main) { [weak self] in
            self?.timerUpdate()
        }
    }
    func timerUpdate() {
        guard let viewModel = viewModel as? LargeWidgetViewModel else { return  }
        guard let dataSource = viewModel.dataSource else { return }
        for visibleCell in self.collectionView.visibleCells {
            if let indexPath = self.collectionView.indexPath(for: visibleCell) {
                let section = dataSource[indexPath.section]
                let item = section.items[indexPath.item]
                switch item {
                case .flipClockItem(let attributes):
                    (visibleCell as? LargeWidgetFlipClockCell)?.config(with: attributes)
                default: break
                }
            }
        }
    }
}
extension LargeWidgetController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}
extension LargeWidgetController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel as? LargeWidgetViewModel else { return 0 }
        guard let dataSource = viewModel.dataSource else { return 0 }
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? LargeWidgetViewModel else { return 0 }
        guard let dataSource = viewModel.dataSource else { return 0 }
        let section = dataSource[section]
        return section.items.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.app.dequeueReusableSupplementaryView(ofKind: kind, withClass: AppWidgetHeaderSupplementaryView.self, for: indexPath)
        if let viewModel = viewModel as? LargeWidgetViewModel, let dataSource = viewModel.dataSource {
            let section = dataSource[indexPath.section]
            supplementaryView.config(supplementary: section.supplementary)
        }
        return  supplementaryView
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.app.dequeueReusableCell(cellClass: UICollectionViewCell.self, for: indexPath)
        guard let viewModel = viewModel as? LargeWidgetViewModel else { return cell }
        guard let dataSource = viewModel.dataSource else { return cell }
        let section = dataSource[indexPath.section]
        let item = section.items[indexPath.item]
        switch item {
        case .flipClockItem(let attributes):
            let cell = collectionView.app.dequeueReusableCell(cellClass: LargeWidgetFlipClockCell.self, for: indexPath)
            cell.config(with: attributes)
            return cell
        case .flowItem(let attributes):
            let cell = collectionView.app.dequeueReusableCell(cellClass: LargeWidgetFlowCell.self, for: indexPath)
            cell.config(with: attributes)
            return cell
        default:
            return collectionView.app.dequeueReusableCell(cellClass: UICollectionViewCell.self, for: indexPath)
        }
    }
}
// MARK: - JXPagingViewListViewDelegate
extension LargeWidgetController: JXPagingViewListViewDelegate {
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
