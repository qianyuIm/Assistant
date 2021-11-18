//
//  AppLanguageController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class AppLanguageController: AppBaseCollectionVMController {
    lazy var saveItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.style = .done
        return item
    }()
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<AppLanguageSection> = {
        return RxCollectionViewSectionedReloadDataSource<AppLanguageSection> { dataSource, collectionView, indexPath, item in
            let cell = collectionView.app.dequeueReusableCell(cellClass: AppLanguageCell.self, for: indexPath)
            cell.config(item)
            return cell
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
        navigationItem.rightBarButtonItem = saveItem
        collectionView.app.register(nibWithCellClass: AppLanguageCell.self)
    }
    override func setupLanguage() {
        super.setupLanguage()
        navigationItem.title = R.string.navigation.languageTitle.key.app.navigationLocalized()
        saveItem.title = R.string.localizable.commonSave.key.app.localized()
    }
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppLanguageViewModel else { return }
        let trigger = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = AppLanguageViewModel.Input(trigger: trigger,
                                               saveTrigger: saveItem.rx.tap.asDriver(),
                                              selection: collectionView.rx.modelSelected(AppLanguageItem.self).asDriver())
        let output = viewModel.transform(input: input)
        output.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.saveEnabled.subscribe(onNext: { [weak self] isEnabled in
            self?.saveItem.isEnabled = isEnabled
        }).disposed(by: rx.disposeBag)
        output.saved.drive(onNext: { [weak self] () in
            QYHUD.showHUD(message: "正在设置")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                QYHUD.showHUD(message: "设置成功")
                QYHUD.hideHUD()
                self?.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: rx.disposeBag)
    }
}
