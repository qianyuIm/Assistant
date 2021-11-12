//
//  MyWidgetsViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/12.
//

import RxSwift
import RxCocoa

class MyWidgetsViewModel: AppViewModel {
    struct Input {
        let trigger: Observable<Void>
    }
    struct Output {
        let dataSource: BehaviorRelay<[AppWidgetSection]>
    }
}
extension MyWidgetsViewModel: AppViewModelable {
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[AppWidgetSection]>(value: [])
        input.trigger.flatMapLatest { [weak self]() -> Observable<[AppWidgetSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.configDataSource()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        
        return Output(dataSource: dataSource)
    }
    func configDataSource() -> Observable<[AppWidgetSection]> {
        let small = R.string.localizable.widgetSegmentSmall.key.app.localized()
        let smallSection = AppWidgetSection.small(title: small)
        let medium = R.string.localizable.widgetSegmentMedium.key.app.localized()
        let mediumSection = AppWidgetSection.small(title: medium)
        let large = R.string.localizable.widgetSegmentLarge.key.app.localized()
        let largeSection = AppWidgetSection.small(title: large)
        return Observable.just([smallSection,mediumSection,largeSection])
    }
}
