//
//  SmallWidgetViewModel.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import RxSwift
import RxCocoa


class SmallWidgetViewModel: AppViewModel {
    struct Input {
        let trigger: Observable<Void>
    }
    struct Output {
        let dataSource: BehaviorRelay<[SmallWidgetSection]>
    }
}

extension SmallWidgetViewModel: AppViewModelable {
    
    
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[SmallWidgetSection]>(value: [])
        input.trigger.flatMapLatest { [weak self] () -> Observable<[SmallWidgetSection]> in
            guard let strongSelf = self else {
                return .empty()
            }
            return strongSelf.config()
        }.bind(to: dataSource).disposed(by: rx.disposeBag)
        
        //        input.selection.asObservable().map { $0.viewModel }.bind(to: itemSelected).disposed(by: rx.disposeBag)
        
        
        return Output(dataSource: dataSource)
    }
}

extension SmallWidgetViewModel {
    
    func config() -> Observable<[SmallWidgetSection]> {
        let recommendSection = SmallWidgetSection
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
        let generalToolsSection = SmallWidgetSection
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
        
        let xPanelSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_panel(),
                                      title: R.string.widgets
                                        .sectionXPanel.key
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
        
        let dashboardSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_dashBoard(),
                                      title: R.string.widgets
                                        .sectionDashboard.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let clockSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_clock(),
                                      title: R.string.widgets
                                        .sectionClock.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let quickLauncherSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_quick(),
                                      title: R.string.widgets
                                        .sectionQuickLauncher.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let calendarSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_calendar(),
                                      title: R.string.widgets
                                        .sectionCalendar.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let daysMatterSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_matter(),
                                      title: R.string.widgets
                                        .sectionDaysMatter.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let systemInfoSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_system(),
                                      title: R.string.widgets
                                        .sectionSystemInfo.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        
        let progressSection = SmallWidgetSection
            .xPanelSection(supplementary:
                                .init(icon: R.image.icon_widget_section_progress(),
                                      title: R.string.widgets
                                        .sectionProgress.key
                                        .app.widgetsLocalized(),
                                      routerPattern: "",
                                      router: true),
                           items: [
                            .flipClockItem(attributes: AppWidgetAttributes())
                           ])
        return Observable.just([recommendSection,generalToolsSection,
                                xPanelSection,dashboardSection,
                                clockSection,quickLauncherSection,
                                calendarSection,daysMatterSection,
                                systemInfoSection,progressSection])
    }
}
