//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxSwift
import RxCocoa


class MediumWidgetViewModel: AppViewModel {
    struct Input {
        let trigger: Observable<Void>
    }
    struct Output {
        let dataSource: BehaviorRelay<[MediumWidgetSection]>
    }
}

extension MediumWidgetViewModel: AppViewModelable {
    
    
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[MediumWidgetSection]>(value: [])
        input.trigger.flatMapLatest { [weak self] () -> Observable<[MediumWidgetSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.config()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        
        //        input.selection.asObservable().map { $0.viewModel }.bind(to: itemSelected).disposed(by: rx.disposeBag)
        
        
        return Output(dataSource: dataSource)
    }
}

extension MediumWidgetViewModel {
    
    func config() -> Observable<[MediumWidgetSection]> {
        let recommendSection = MediumWidgetSection
            .recommendSection(supplementary:
                                    .init(icon: R.image.icon_widget_section_recommend(),
                                          title: R.string.widgets
                                            .sectionRecommend.key
                                            .app.widgetsLocalized(),
                                          routerPattern: "",
                                          router: false),
                              items: [
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes()),
                                .flipClockItem(attributes: AppWidgetAttributes())
                                
                              ])
        let generalToolsSection = MediumWidgetSection
            .generalToolsSection(supplementary:
                                        .init(icon: R.image.icon_widget_section_tools(),
                                              title: R.string.widgets
                                                .sectionGeneralTools.key
                                                .app.widgetsLocalized(),
                                              routerPattern: "",
                                              router: true),
                                 items: [
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes()),
                                    .flipClockItem(attributes: AppWidgetAttributes())
                                 ])
        
        
        return Observable.just([recommendSection,generalToolsSection])
    }
}
