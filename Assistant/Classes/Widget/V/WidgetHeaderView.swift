//
//  WidgetHeaderView.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import RxTheme

class WidgetHeaderView: UIView {
    var dataSource = BehaviorRelay<[WidgetHeaderSection]>(value: [])
    fileprivate let contentInsetTopBottom: CGFloat = 12
    /// 行间距
    fileprivate var cellWidth: Int = Int(QYInch.value(74))
    fileprivate var cellHeight: Int = Int(QYInch.value(76))
    fileprivate let minimumInteritemSpacing: Int = 0
    fileprivate let minimumLineSpacing: Int = 8
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(minimumLineSpacing)
        layout.minimumInteritemSpacing = CGFloat(minimumInteritemSpacing)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: contentInsetTopBottom, left: QYInch.left, bottom: contentInsetTopBottom, right: QYInch.right)
        collectionView.app.register(nibWithCellClass: WidgetHeaderViewCell.self)
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bind()
        bindTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<WidgetHeaderSection> { datasource, collectionView, indexPath, item in
            let cell = collectionView.app.dequeueReusableCell(cellClass: WidgetHeaderViewCell.self, for: indexPath)
            cell.config(item)
            return cell
        }
        self.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        collectionView.rx
            .modelSelected(WidgetHeaderItem.self).asObservable()
            .subscribe  (onNext: { headerItem in
                AppRouter.shared.open(headerItem.pattern, context: nil)
        }).disposed(by: rx.disposeBag)
    }
    func bindTheme() {
        collectionView.theme.backgroundColor = appThemeProvider.attribute { $0.backgroundColor }
    }
}

extension WidgetHeaderView {
    func viewHeight() -> Int {
        let dataSource = self.dataSource.value
        var heigh: Int = 0
        guard let _ = dataSource.first else {
            return heigh
        }
        heigh = cellHeight + Int(contentInsetTopBottom) * 2
        return heigh
    }
}

