//
//  AppThemeController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AppThemeController: AppBaseCollectionVMController {
    
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<AppThemeSection> = {
        return RxCollectionViewSectionedReloadDataSource<AppThemeSection> { dataSource, collectionView, indexPath, item in
            switch item {
            case .settingSectionItem(let item):
                let cell = collectionView.app.dequeueReusableCell(cellClass: AppThemeSettingCell.self, for: indexPath)
                cell.config(item)
                return cell
            case .themeSectionItem(let item):
                let cell = collectionView.app.dequeueReusableCell(cellClass: AppThemeCell.self, for: indexPath)
                cell.config(item)
                return cell
            }
            
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func createLayout() -> UICollectionViewLayout {
        
        
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let strongSelf = self else { return nil }
            let sourceSection = strongSelf.dataSource[sectionIndex]
            let rows = sourceSection.rowCount
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let groupHeight = rows == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(1/3)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: rows)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 0, trailing: 10)
            return section
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 10
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    override func setupUI() {
        super.setupUI()
        collectionView.app.register(nibWithCellClass: AppThemeCell.self)
        collectionView.app.register(nibWithCellClass: AppThemeSettingCell.self)
        
    }
    override func setupLanguage() {
        super.setupLanguage()
        navigationItem.title = R.string.navigation.themeTitle.key.app.navigationLocalized()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppThemeViewModel else { return }
        let trigger = Observable.just(())
        let input = AppThemeViewModel.Input(trigger: trigger,
                                            selection: collectionView.rx.modelSelected(AppThemeSectionItem.self).asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        
    }
    
}
