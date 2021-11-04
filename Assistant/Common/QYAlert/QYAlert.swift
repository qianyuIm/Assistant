//
//  QYAlert.swift
//  Qianyu
//
//  Created by cyd on 2020/12/28.
//

import UIKit
import SwiftEntryKit
import RxTheme

struct AlertSenderContent {
    var title: String
    var action: (() -> Void)?
    
}

class QYAlert {
    
    /// 通用弹窗
    /// - Parameters:
    ///   - title:
    ///   - message:
    ///   - doneContent:
    ///   - cancelContent:
    class func alert(title: String? = nil,
                     message: String? = nil,
                     doneContent: AlertSenderContent? = nil,
                     cancelContent: AlertSenderContent? = nil) {
        let contentView = QYAlertView(title: title, message: message, doneContent: doneContent, cancelContent: cancelContent)
        SwiftEntryKit.display(entry: contentView, using: alertAttributes())
    }
    
    class func dismiss(completion: (() -> Void)? = nil) {
        SwiftEntryKit.dismiss(.displayed, with: completion)
    }
}
private extension QYAlert {
    class func alertAttributes() -> EKAttributes {
        var attributes: EKAttributes = .centerFloat
        attributes.displayMode = .inferred
        attributes.windowLevel = .alerts
        attributes.statusBar = .ignored
        attributes.displayDuration = .infinity
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.screenBackground = .color(color: .init(UIColor.black.withAlphaComponent(0.3)))
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .easeOut
        )
        attributes.entranceAnimation = .init(
               translate: .init(
                   duration: 0.7,
                   spring: .init(damping: 0.7, initialVelocity: 0)
               ),
               scale: .init(
                   from: 0.7,
                   to: 1,
                   duration: 0.4,
                   spring: .init(damping: 1, initialVelocity: 0)
               )
        )
        attributes.exitAnimation = .init(
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.2
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 5
            )
        )
        attributes.positionConstraints.maxSize = .init(
            width: .offset(value: QYInch.value(50)),
            height: .intrinsic
        )
//        attributes.lifecycleEvents = .init(willAppear: nil, didAppear: nil, willDisappear: nil, didDisappear: {
//            let aa = AppUtility.topMost
//            aa?.hbd_setNeedsUpdateNavigationBar()
//        })
        
        return attributes
    }
}

private class QYAlertView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = QYFont.fontMedium(17)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = QYFont.fontRegular(13)
        label.numberOfLines = 0
        return label
    }()
    lazy var senderWrapper: UIView = {
        let view = UIView()
        return view
    }()
    lazy var doneSender: QYButton = {
        let sender = QYButton()
        sender.titleLabel?.font = QYFont.fontMedium(16)
        sender.addTarget(self, action: #selector(doneSenderAction), for: .touchUpInside)
        return sender
    }()
    lazy var cancelSender: QYButton = {
        let sender = QYButton()
        sender.titleLabel?.font = QYFont.fontMedium(16)
        sender.addTarget(self, action: #selector(cancelSenderAction), for: .touchUpInside)
        return sender
    }()
    var doneContent: AlertSenderContent?
    var cancelContent: AlertSenderContent?
    init(title: String? = nil,
         message: String? = nil,
         doneContent: AlertSenderContent? = nil,
         cancelContent: AlertSenderContent? = nil) {
        super.init(frame: .zero)
        self.doneContent = doneContent
        self.cancelContent = cancelContent
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(senderWrapper)
        senderWrapper.addSubview(doneSender)
        senderWrapper.addSubview(cancelSender)
        titleLabel.text = title
        messageLabel.text = message
        cancelSender.setTitle(cancelContent?.title, for: .normal)
        doneSender.setTitle(doneContent?.title, for: .normal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(QYInch.value(16))
        }
        let margin = QYInch.value(8)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }
        senderWrapper.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(messageLabel.snp.bottom).offset(margin)
            make.bottom.equalTo(-margin)
        }
        if (cancelContent != nil && doneContent != nil) {
            cancelSender.snp.makeConstraints { (make) in
                make.top.equalTo(margin)
                make.left.equalTo(margin)
                make.width.equalTo(QYInch.value(116))
                make.bottom.equalTo(-margin)
            }
            doneSender.snp.makeConstraints { (make) in
                make.centerY.height.width.equalTo(cancelSender)
                make.right.equalToSuperview()
            }
        } else if (cancelContent == nil && doneContent != nil) {
            doneSender.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            }
        } else if (cancelContent != nil && doneContent == nil) {
            cancelSender.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            }
        }
        
        bindUI()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneSenderAction() {
        QYAlert.dismiss(completion: nil)
        self.doneContent?.action?()
    }
    @objc func cancelSenderAction() {
        QYAlert.dismiss(completion: nil)
        self.cancelContent?.action?()
    }
    func bindUI() {
        app.addRoundCorners(.allCorners, radius: 8)
        theme.backgroundColor = appThemeProvider.attribute { $0.backgroundColor }
        titleLabel.theme.textColor = appThemeProvider.attribute { $0.textTheme.titleColor }
        messageLabel.theme.textColor = appThemeProvider.attribute { $0.textTheme.subtitleColor }
        cancelSender.theme.titleColor(from: appThemeProvider.attribute { $0.textTheme.subtitleColor }, for: .normal)
        doneSender.theme.titleColor(from: appThemeProvider.attribute { $0.primaryColor }, for: .normal)

    }
    
}

