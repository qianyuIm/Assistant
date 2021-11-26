//
//  AppClockBorderView.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit
import SnapKit

class AppClockBorderView: UIView {

    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes? {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            updateBorder(with: attributes!)
        }
    }
    lazy var classicBorder: AppClockClassicBorderView = {
        let border = AppClockClassicBorderView()
        return border
    }()
    lazy var artNouveauBorder: AppClockArtNouveauBorderView = {
        let border = AppClockArtNouveauBorderView()
        return border
    }()
    lazy var steampunkBorder: AppClockSteampunkBorderView = {
        let border = AppClockSteampunkBorderView()
        return border
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppClockBorderView {
    func updateBorder(with attributes: AppWidgetAttributes) {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        switch attributes.clockAttributes.displayStyle {
        case .classic:
            addSubview(self.classicBorder)
            classicBorder.clockAttributes = attributes.clockAttributes
            classicBorder.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .artNouveau:
            addSubview(self.artNouveauBorder)
            artNouveauBorder.clockAttributes = attributes.clockAttributes
            artNouveauBorder.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .steampunk:
            addSubview(self.steampunkBorder)
            steampunkBorder.clockAttributes = attributes.clockAttributes
            steampunkBorder.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
