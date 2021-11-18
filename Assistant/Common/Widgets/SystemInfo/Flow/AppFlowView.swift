//
//  AppFlowView.swift
//  Assistant
//
//  Created by cyd on 2021/11/18.
//

import UIKit

class AppFlowView: UIView {
    lazy var backgroundView: AppWidgetBackgroundView = {
        let view = AppWidgetBackgroundView()
        return view
    }()
    private var _attributes: AppWidgetAttributes?
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            if _attributes == attributes {
                return
            }
            _attributes = attributes
            var cornerRadius: CGFloat = 0
            var corners: UIRectCorner = []
            (corners, cornerRadius) = attributes.roundCorners.cornerValues
            self.app.addRoundCorners(corners, radius: cornerRadius)
            backgroundView.style = .init(background: attributes.background)
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
extension AppFlowView {
    func setupUI() {
        addSubview(backgroundView)
    }
}
