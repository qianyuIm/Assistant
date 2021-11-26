//
//  AppClockView.swift
//  Assistant
//
//  Created by cyd on 2021/11/26.
//

import UIKit
import SnapKit

class AppClockView: UIView {
    lazy var borderView: AppClockBorderView = {
        let view = AppClockBorderView()
        return view
    }()
    lazy var indicatorView: AppClockIndicatorView = {
        let view = AppClockIndicatorView()
        return view
    }()
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes? {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            borderView.attributes = attributes
            indicatorView.attributes = attributes
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppClockView {
    func setupUI() {
        addSubview(borderView)
        addSubview(indicatorView)
        setupConstraints()
    }
    func setupConstraints() {
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
