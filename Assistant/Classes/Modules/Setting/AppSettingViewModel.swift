//
//  AppSettingViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/5.
//

import Foundation
import RxSwift
import RxCocoa

class AppSettingViewModel: AppViewModel {
    
    let itemSelected = PublishSubject<AppSettingCellViewModel>()

    struct Input {
        /// 初始化
        let trigger: Observable<Void>
        let selection: Driver<AppSettingSectionItem>

    }
    struct Output {
        let dataSource: BehaviorRelay<[AppSettingSection]>
    }
}
extension AppSettingViewModel: AppViewModelable {
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[AppSettingSection]>(value: [])
        input.trigger.flatMapLatest { [weak self] () -> Observable<[AppSettingSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.config()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        
        input.selection.asObservable().map { $0.viewModel}.bind(to: itemSelected).disposed(by: rx.disposeBag)
        
        return Output(dataSource: dataSource)
    }
}
extension AppSettingViewModel {
    func config() -> Observable<[AppSettingSection]> {
        var sections: [AppSettingSection] = []
        let profileSection = AppSettingSection
            .profileSection(title: "用户设置",
                            items: [
                                .profileItem(viewMode: .init(title: "用户", iconImage: AppIconFontIcons.icon_settings.image(size: 24), arrowImage: nil,pattern: ""))
                            ])
        let configSection = AppSettingSection
            .configSection(title: R.string.localizable.setting.key.app.localized(),
                           items: [
                            .limitItem(viewMode: .init(title: R.string.localizable.settingLimit.key.app.localized(),
                                                          iconImage: AppIconFontIcons.icon_setting_limit.image(size: 24),
                                                          pattern: AppRouterType.limit.pattern)),
                            .languageItem(viewMode: .init(title: R.string.localizable.settingLanguage.key.app.localized(),
                                                          iconImage: AppIconFontIcons.icon_setting_language.image(size: 24),
                                                          pattern: AppRouterType.languageSetting.pattern)),
                            .themeItem(viewMode: .init(title: R.string.localizable.settingTheme.key.app.localized(),
                                                       iconImage: AppIconFontIcons.icon_setting_theme.image(size: 24),
                                                       pattern:AppRouterType.themeSetting.pattern)),
                            .permissionItem(viewMode: .init(title: R.string.localizable.settingPermissions.key.app.localized(),
                                                            iconImage: AppIconFontIcons.icon_setting_permission.image(size: 24),
                                                            pattern:AppRouterType.permission.pattern)),
                            .aboutItem(viewMode: .init(title: R.string.localizable.settingAbout.key.app.localized(),
                                                       iconImage: AppIconFontIcons.icon_setting_about.image(size: 24),
                                                       pattern:AppRouterType.about.pattern)),
                            .questionItem(viewMode: .init(title: R.string.localizable.settingQuestion.key.app.localized(),
                                                          iconImage: AppIconFontIcons.icon_setting_question.image(size: 24),
                                                          pattern:AppRouterType.question.pattern))
                           ])
    
        sections.append(profileSection)
        sections.append(configSection)

        return Observable.just(sections)
    }
}
 
