//
//  AppWidgetsViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import RxSwift
import RxCocoa

enum AppWidgetSection {
    case small(title: String)
    case medium(title: String)
    case large(title: String)
    var title: String {
        switch self {
        case .small(let title):
            return title
        case .medium(let title):
            return title
        case .large(let title):
            return title
        }
    }
}

class AppWidgetsViewModel: AppViewModel {
    struct Input {
        let retry: Observable<Void>
    }
    struct Output {
        let headerDataSource: BehaviorRelay<[WidgetHeaderSection]>
        let dataSource: BehaviorRelay<[AppWidgetSection]>
    }
}
extension AppWidgetsViewModel: AppViewModelable {
    func transform(input: Input) -> Output {
        let headerDataSource = BehaviorRelay<[WidgetHeaderSection]>(value: [])
        let dataSource = BehaviorRelay<[AppWidgetSection]>(value: [])
        input.retry.flatMapLatest { [weak self]() -> Observable<([WidgetHeaderSection],[AppWidgetSection])> in
            guard let strongSelf = self else {
                return .empty()
            }
            return Observable.zip(strongSelf.configHeaderDataSource(),
                                  strongSelf.configDataSource())
        }.subscribe (onNext: { (headers, sections) in
            headerDataSource.accept(headers)
            dataSource.accept(sections)
        }).disposed(by: rx.disposeBag)
        
        return Output(headerDataSource:headerDataSource, dataSource: dataSource)
    }
    
    func configHeaderDataSource() -> Observable<[WidgetHeaderSection]> {
        let transparentItem = WidgetHeaderItem(imageName: R.string.image.widgetBannerTransparent.key.app.imageLocalized(),
                                                  pattern: AppRouterType.transparent.pattern)
        let questionItem = WidgetHeaderItem(imageName: R.string.image.widgetBannerQuestion.key.app.imageLocalized(),
                                               pattern: AppRouterType.question.pattern)
        let section = WidgetHeaderSection(items: [transparentItem,questionItem])
        return Observable.just([section])

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

