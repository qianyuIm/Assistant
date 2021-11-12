//
//  AppThemeViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxCocoa
import RxSwift

class AppThemeViewModel: AppViewModel {
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<AppThemeSectionItem>
    }
    struct Output {
        let dataSource: BehaviorRelay<[AppThemeSection]>
    }
    var currentThemeModel: BehaviorRelay<String>
    var currentThemeSwatch: BehaviorRelay<AppColorSwatch?>

    required init() {
        currentThemeModel = BehaviorRelay(value: QYConfig.Theme.currentModelKey())
        currentThemeSwatch = BehaviorRelay(value: AppColorSwatch(rawValue: QYConfig.Theme.themeSwatchIndex))
        super.init()
    }
    
}
extension AppThemeViewModel: AppViewModelable {
    func transform(input: Input) -> Output {
        
        let dataSource = BehaviorRelay<[AppThemeSection]>(value: [])
        
        input.selection.drive(onNext: { (themeSectionItem) in
            switch themeSectionItem {
            case .settingSectionItem(let item):
                self.currentThemeModel.accept(item.mode)
                appThemeProvider.type.switchLight()
                
                break
            case .themeSectionItem(let item):
                self.currentThemeSwatch.accept(item.colorSwatch)
                
                break
            
            }
        }).disposed(by: rx.disposeBag)
        
        let refresh = Observable.of(input.trigger,
                                    input.selection.asObservable().mapToVoid()).merge()
        
        refresh.flatMapLatest { [weak self] () -> Observable<[AppThemeSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.config()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        
        
        
        
        return Output(dataSource: dataSource)
    }
}
extension AppThemeViewModel {
    func config() -> Observable<[AppThemeSection]> {
        let currentThemeModel = self.currentThemeModel.value
        let autoMode = AppThemeSectionItem.settingSectionItem(item: .init(mode: QYConfig.Theme.auto, disPlayName: R.string.localizable.commonAuto.key.app.localized(), isSelected: currentThemeModel == QYConfig.Theme.auto))
        
        let lightMode = AppThemeSectionItem.settingSectionItem(item: .init(mode: QYConfig.Theme.light, disPlayName: R.string.localizable.commonLightMode.key.app.localized(), isSelected: currentThemeModel == QYConfig.Theme.light))
        let darkMode = AppThemeSectionItem.settingSectionItem(item: .init(mode: QYConfig.Theme.dark, disPlayName: R.string.localizable.commonDarkMode.key.app.localized(), isSelected: currentThemeModel == QYConfig.Theme.dark))
        let settingSection = AppThemeSection.settingSection(items: [autoMode,lightMode,darkMode])
        let themeItems = QYConfig.Theme.support.map { swatch in
            return AppThemeSectionItem.themeSectionItem(item: .init(colorSwatch: swatch, isSelected: currentThemeSwatch.value == swatch))
        }
        let themeSection = AppThemeSection.themeSection(items: themeItems)
        return Observable.just([settingSection, themeSection])
    }
}
