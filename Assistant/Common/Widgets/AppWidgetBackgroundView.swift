//
//  AppWidgetBackgroundView.swift
//  Assistant
//
//  Created by cyd on 2021/11/17.
//

import UIKit

class AppWidgetBackgroundView: UIView {

    struct Style {
        let background: AppWidgetAttributes.BackgroundStyle
        let displayMode: AppWidgetAttributes.DisplayMode
    }
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        NotificationCenter.Theme.add(.WidgetThemeChangeNotification, observer: self, selector: #selector(updateTheme), object: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var style: Style! {
        didSet {
            guard let style = style else {
                return
            }
            var backgroundColor: UIColor = .clear
            var backgroundImage: UIImage?
            switch style.background {
            case .clear:
                break
            case .color(let color):
                backgroundColor = color.color(for: traitCollection,
                                                 mode: style.displayMode)
            case .image(let imageName):
                backgroundImage = UIImage(named: imageName)
            }
            layer.backgroundColor = backgroundColor.cgColor
            imageView.image = backgroundImage
        }
    }
    @objc func updateTheme() {
        switch style.background {
        case .color(color: let color):
            layer.backgroundColor = color.color(for: traitCollection,
                                                   mode: style.displayMode).cgColor
        default:
            break
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateTheme()
    }
}
