//
//  AppSettingController.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

//private let reuseIdentifier = R.reuseIdentifier.appSettingCell.identifier

class AppSettingController: AppBaseCollectionVMController {
    
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<AppSettingSection> = {
        return RxCollectionViewSectionedReloadDataSource<AppSettingSection> { dataSource, collectionView, indexPath, item in
            switch item {
            case .profileItem(let viewModel):
                let cell = collectionView.app.dequeueReusableCell(cellClass: AppSettingCell.self, for: indexPath)
                cell.config(viewModel)
                return cell
            case .languageItem(let viewMode),
                    .themeItem(let viewMode),
                    .permissionItem(let viewMode),
                    .aboutItem(let viewMode),
                    .questionItem(let viewMode),
                    .limitItem(let viewMode):
                let cell = collectionView.app.dequeueReusableCell(cellClass: AppSettingCell.self, for: indexPath)
                cell.config(viewMode)
                return cell
            }
        } configureSupplementaryView: { dataSource, collectionView, elementKind, indexPath in
            let section = dataSource[indexPath.section]
            return UICollectionReusableView()
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func setupUI() {
        super.setupUI()
        collectionView.app.register(nibWithCellClass: AppSettingCell.self)
    }
    override func setupLanguage() {
        super.setupLanguage()
        navigationItem.title = R.string.navigation.settingTitle.key.app.navigationLocalized()
    }
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppSettingViewModel else { return  }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = AppSettingViewModel.Input(trigger: trigger,
                                              selection: collectionView.rx.modelSelected(AppSettingSectionItem.self).asDriver())
        let output = viewModel.transform(input: input)
        output.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        viewModel.itemSelected.subscribe (onNext: { cellViewModel in
            AppRouter.shared.open(cellViewModel.pattern, context: nil)
        }).disposed(by: rx.disposeBag)
    }
    
}
extension AppSettingController {
    
}
