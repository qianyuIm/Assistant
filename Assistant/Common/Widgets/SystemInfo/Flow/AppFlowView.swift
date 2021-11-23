//
//  AppFlowView.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit
//import TrafficPolice
class AppFlowView: UIView {
    lazy var backgroundView: AppWidgetBackgroundView = {
        let view = AppWidgetBackgroundView()
        return view
    }()
    lazy var smallFlowView: AppSmallFlowView = {
        let view = AppSmallFlowView.create()
        return view
    }()
    lazy var mediumFlowView: AppMediumFlowView = {
        let view = AppMediumFlowView.create()
        return view
    }()
    lazy var largeFlowView: AppLargeFlowView = {
        let view = AppLargeFlowView.create()
        return view
    }()
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            if _attributes == attributes {
                return
            }
            if _attributes == nil {
                setupUI(with: attributes)
            }
            var cornerRadius: CGFloat = 0
            var corners: UIRectCorner = []
            (corners, cornerRadius) = attributes.roundCorners.cornerValues
            self.app.addRoundCorners(corners, radius: cornerRadius)
            backgroundView.style = .init(background: attributes.background)
            _attributes = attributes
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension AppFlowView {
    func setupUI(with attributes: AppWidgetAttributes) {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        switch attributes.widgetFamily {
        case .small:
            addSubview(smallFlowView)
            smallFlowView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .medium:
            addSubview(mediumFlowView)
            mediumFlowView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .large:
            addSubview(largeFlowView)
            largeFlowView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        TrafficManager.shared.updateSummary { summary in
            switch attributes.widgetFamily {
            case .small:
                self.smallFlowView.updateSummary(summary)
            case .medium:
                self.mediumFlowView.updateSummary(summary)
            case .large:
                self.largeFlowView.updateSummary(summary)
            }
        }
    }
    func updateUI(with attributes: AppWidgetAttributes) {
    }
}
