//
//  AppClockBorderView.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit
import SnapKit

class AppClockIndicatorView: UIView {

    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes? {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            updateIndicator(with: attributes!)
        }
    }
    lazy var classicIndicatorView: AppClockClassicIndicatorView = {
        let indicatorView = AppClockClassicIndicatorView()
        return indicatorView
    }()
    lazy var artNouveauIndicatorView: AppClockArtNouveauIndicatorView = {
        let indicatorView = AppClockArtNouveauIndicatorView()
        return indicatorView
    }()
    lazy var steampunkIndicatorView: AppClockClassicIndicatorView = {
        let indicatorView = AppClockClassicIndicatorView()
        return indicatorView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppClockIndicatorView {
    func updateIndicator(with attributes: AppWidgetAttributes) {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        switch attributes.clockAttributes.displayStyle {
        case .classic:
            addSubview(self.classicIndicatorView)
            classicIndicatorView.clockAttributes = attributes.clockAttributes
            classicIndicatorView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .artNouveau:
            addSubview(self.artNouveauIndicatorView)
            artNouveauIndicatorView.clockAttributes = attributes.clockAttributes
            artNouveauIndicatorView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .steampunk:
            addSubview(self.steampunkIndicatorView)
            steampunkIndicatorView.clockAttributes = attributes.clockAttributes
            steampunkIndicatorView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
