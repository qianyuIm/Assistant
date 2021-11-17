//
//  AppLanguageViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxDataSources
import RxSwift
import RxCocoa
import Foundation

struct AppLanguageSection {
    var items: [Item]
}
struct AppLanguageItem {
    var language: String
    var disPlayName: String
    var isSelected: Bool
}

extension AppLanguageSection: SectionModelType {
    typealias Item = AppLanguageItem
    init(original: AppLanguageSection, items: [AppLanguageItem]) {
        self = original
        self.items = items
    }
}

class AppLanguageViewModel: AppViewModel {
    struct Input {
        let trigger: Observable<Void>
        let saveTrigger: Driver<Void>
        let selection: Driver<AppLanguageItem>
    }
    struct Output {
        let dataSource: BehaviorRelay<[AppLanguageSection]>
        let saveEnabled: BehaviorRelay<Bool>
        let saved: Driver<Void>
    }
    var currentLanguage: BehaviorRelay<String>
    required init() {
        currentLanguage = BehaviorRelay(value: QYConfig.Language.current())
        super.init()
    }
}
extension AppLanguageViewModel: AppViewModelable {
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[AppLanguageSection]>(value: [])
        let saveEnabled = BehaviorRelay<Bool>(value: false)
        input.selection.drive(onNext: { (languageItem) in
            let language = languageItem.language
            self.currentLanguage.accept(language)
            saveEnabled.accept(language != QYConfig.Language.current())
        }).disposed(by: rx.disposeBag)
        let refresh = Observable.of(input.trigger,
                                    input.selection.asObservable().mapToVoid()).merge()
        refresh.flatMapLatest { [weak self] () -> Observable<[AppLanguageSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.config()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        let saved = input.saveTrigger.map { () -> Void in
            let language = self.currentLanguage.value
            QYConfig.Language.autoSystem = (QYConfig.Language.auto == language)
            QYConfig.Language.setCurrentLanguage(language)
        }
        return Output(dataSource: dataSource,
                      saveEnabled: saveEnabled,
                      saved: saved.asDriver(onErrorJustReturn: ()))
    }
}
extension AppLanguageViewModel {
    func config() -> Observable<[AppLanguageSection]> {
        let languages = QYConfig.Language.support()
        var items = languages.map { language in
            return AppLanguageItem(language: language,
                                   disPlayName: QYConfig.Language.displayNameForLanguage(language),
                                   isSelected: (language == self.currentLanguage.value))
        }
        let autoItem = AppLanguageItem(language: QYConfig.Language.auto, disPlayName: R.string.localizable.commonAuto.key.app.localized(), isSelected: self.currentLanguage.value == QYConfig.Language.auto)
        items.insert(autoItem, at: 0)
        let section = AppLanguageSection(items: items)
        return Observable.just([section])
    }
}
