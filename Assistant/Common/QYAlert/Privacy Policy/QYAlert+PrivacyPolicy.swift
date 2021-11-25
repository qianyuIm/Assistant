//
//  QYAlert+Privacy.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit
import SwiftEntryKit
import SwiftyUserDefaults
import AttributedString
import SnapKit
extension QYAlert {
    /// 启动隐私协议
    class func alertPrivacyPolicy() {
        // 判断
        let launchPrivacyPolicy = AppGroupDefaults.launchPrivacyPolicyKey
        if launchPrivacyPolicy == QYConfig.appVersion { return }
        showPrivacyPolicy()
    }
}

private extension QYAlert {
    class func launchPrivacyPolicyAttributes() -> EKAttributes {
        var attributes: EKAttributes
        attributes = .centerFloat
        attributes.displayMode = .inferred
        attributes.displayDuration = .infinity
        if AppUtility.topMostStatusBarStyle == .darkContent {
            attributes.statusBar = .dark
        } else {
            attributes.statusBar = .light
        }
        attributes.screenBackground = .clear
         attributes.screenInteraction = .absorbTouches
         attributes.entryInteraction = .absorbTouches
         attributes.scroll = .disabled
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
         attributes.popBehavior = .animated(
             animation: .init(
                 translate: .init(duration: 0.35)
             )
         )
         attributes.shadow = .active(
             with: .init(
                 color: .black,
                 opacity: 0.3,
                 radius: 5
             )
         )
         attributes.positionConstraints.size = .init(
             width: .fill,
             height: .fill
         )
         attributes.positionConstraints.verticalOffset = 0
         attributes.positionConstraints.safeArea = .overridden
        /// TODO: fix 2.0.0 SwiftEntryKit 状态栏没有适配好
        /// 在这做个修复  等待吧
        attributes.lifecycleEvents = .init(willAppear: nil, didAppear: nil, willDisappear: nil, didDisappear: {
            DispatchQueue.main.async {
                AppUtility.topMost?.setNeedsStatusBarAppearanceUpdate()
            }
        })
        return attributes
    }
    class func showPrivacyPolicy() {
        let privacyPolicyController = QYPrivacyPolicyController()
        let naVc = AppNavigationController(rootViewController: privacyPolicyController)
        SwiftEntryKit.display(entry: naVc, using: launchPrivacyPolicyAttributes())
    }
}
private class QYPrivacyPolicyController: UIViewController {
    lazy var privacyPolicyView: QYPrivacyPolicyView = {
        let view = QYPrivacyPolicyView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hbd_barHidden = true
        view.addSubview(privacyPolicyView)
        privacyPolicyView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

private class QYPrivacyPolicyView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "服务协议与隐私政策"
        label.textAlignment = .center
        return label
    }()
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        return textView
    }()
    lazy var policyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var acceptButton: QYBorderButton = {
        let sender = QYBorderButton()
        sender.cornerRadius = 4
        sender.borderWidth = 1
        sender.titleLabel?.font = QYFont.fontRegular(15)
        sender.setTitle("同意", for: .normal)
        sender.addTarget(self, action: #selector(acceptButtonDidClick), for: .touchUpInside)
        return sender
    }()
    lazy var noAcceptButton: QYBorderButton = {
        let sender = QYBorderButton()
        sender.borderWidth = 1
        sender.cornerRadius = 4
        sender.titleLabel?.font = QYFont.fontRegular(15)
        sender.setTitle("不同意并退出", for: .normal)
        sender.addTarget(self, action: #selector(noAcceptButtonDidClick), for: .touchUpInside)
        return sender
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 高亮状态
//        Array<ASAttributedString.Action.Highlight>.defalut = [.foreground(QYColor.privacyPolicyLinkHighlightColor)]
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(policyLabel)
        addSubview(acceptButton)
        addSubview(noAcceptButton)

        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(QYInch.value(20))
        }
        let margin = QYInch.value(8)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(QYInch.value(260))
        }
        policyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom)
                .offset(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }
        noAcceptButton.snp.makeConstraints { (make) in
            make.top.equalTo(policyLabel.snp.bottom)
                .offset(margin)
            make.left.equalTo(margin)
            make.height.equalTo(QYInch.value(40))
            make.width.equalTo(QYInch.value(116))
            make.bottom.equalTo(-margin)
        }
        acceptButton.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(noAcceptButton)
            make.right.equalTo(-margin)
        }
        bindUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func acceptButtonDidClick() {
        AppGroupDefaults.launchPrivacyPolicyKey = QYConfig.appVersion
        QYAlert.dismiss()
    }
    @objc func noAcceptButtonDidClick() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
    func linkAction(_ result: ASAttributedString.Action.Result) {
        switch result.content {
        case .string(let value):
            AppUtility.copy(with: value.string) {
                QYToast.show(R.string.localizable.promptPrivacyPolicyToast.key.localized())
            }
        default:
            break
        }
    }
    func userPolicyAction(_ result: ASAttributedString.Action.Result) {
        let vc = UIViewController()
        self.app.navigationController?.pushViewController(vc, animated: true)
    }
    func privacyPolicyAction(_ result: ASAttributedString.Action.Result) {
        let vc = UIViewController()
        self.app.navigationController?.pushViewController(vc, animated: true)
    }
}

extension QYPrivacyPolicyView {
    func bindUI() {
        self.app.addRoundCorners(.allCorners, radius: 10)
        appThemeProvider.typeStream.subscribe(onNext: {[weak self] themeType in
            guard let strongSelf = self else { return }
            let theme = themeType.associatedObject
            strongSelf.backgroundColor = theme.backgroundColor
            strongSelf.titleLabel.textColor = theme.textTheme.titleColor
            strongSelf.textView.backgroundColor = theme.backgroundColor
            strongSelf.noAcceptButton.borderColor = theme.textTheme.subtitleColor
            strongSelf.noAcceptButton.setTitleColor(theme.textTheme.titleColor, for: .normal)
            strongSelf.acceptButton.borderColor = theme.primaryColor
            strongSelf.acceptButton.setTitleColor(theme.primaryColor, for: .normal)
            strongSelf.bindTextView(theme)
            strongSelf.bindPolicyLabel(theme)
        }).disposed(by: rx.disposeBag)
    }
    // swiftlint:disable comma
    func bindTextView( _ theme: AppThemeProtocol) {
        let titleFont = QYFont.fontRegular(14)
        let linkFont = QYFont.fontRegular(14)
        let describeFont = QYFont.fontRegular(13)
        let titleColor = theme.textTheme.titleColor
        let subtitleColor = theme.textTheme.subtitleColor
        let primaryColor = theme.primaryColor
        textView.attributed.text = """
        \("欢迎使用\(QYConfig.appDisplayName)！\(QYConfig.appDisplayName)的产品及服务由北京XXX公司为您提供。在您使用\(QYConfig.appDisplayName)之前，我们想向您说明\(QYConfig.appDisplayName)的服务条款与隐私政策内容，请您仔细阅读并作出适当的选择：",.font(describeFont), .foreground(subtitleColor))\n\n
        \("1. 《\(QYConfig.appDisplayName)用户协议》的主要内容包括：", .font(titleFont), .foreground(titleColor))\n
        \("协议适用范围、服务内容及形式、软件使用及许可、终端责任安全、用户权利与义务、用户行为规范、知识产权声明、用户信息保护等。",.font(describeFont),.foreground(subtitleColor))\n
        \("2. 关于《\(QYConfig.appDisplayName)隐私政策》，我们特别向您说明：",.font(titleFont), .foreground(titleColor))\n
        \("（1）根据合法、正当、必要的原则，我们会收集实现产品功能所必要的信息，包括：您在注册账户时所填写的信息（昵称、手机号码等）；您的网络日志及设备信息设备型号；当您选择使用部分服务时，我们将在征求您的同意后获取相关提供服务所需的信息，如当您使用与位置有关的服务时，我们可能会获取您设备所在的位置信息。", .font(describeFont),.foreground(subtitleColor))\n
        \("（2）即刻运营方内有严格的数据保护及管理措施，我们会采取安全保障措施努力保护您的个人信息不丢失，不被未经授权地访问、使用、披露、修改或损坏以及其它形式的非法处理。",.font(describeFont),.foreground(subtitleColor))\n
        \("（3）您可以在应用内或您的设备中查询、更正、删除您的信息并对相关授权进行管理。 如您对本公告及相关协议的相关内容有任何意见、建议或疑问，您可以通过",.font(describeFont),.foreground(subtitleColor)) \("1040583846@qq.com",.font(linkFont),.foreground(primaryColor),.action(linkAction)) \("联系我们。如您同意以上内容，您可点击“同意”开始使用。",.font(describeFont),.foreground(subtitleColor))
        """
    }
    func bindPolicyLabel( _ theme: AppThemeProtocol) {
        let font = QYFont.fontRegular(14)
        policyLabel.attributed.text = """
        \("点击查看",.foreground(theme.textTheme.titleColor),.font(font))\("《用户协议》",.foreground(theme.primaryColor),.font(font),.action(userPolicyAction)),\("《隐私协议》",.font(font),.foreground(theme.primaryColor),.action(privacyPolicyAction))\("。",.foreground(theme.textTheme.titleColor),.font(font))
        """
    }
}
