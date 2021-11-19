//
//  AppFlipClockLabel.swift
//  Assistant
//
//  Created by cyd on 2021/11/15.
//

import UIKit
import SnapKit

/// 下一个label开始值
private let kNextLabelStartValue: CGFloat = 0.01
class AppFlipClockLabel: UIView {
    /// 动画执行进度
    var animateValue: CGFloat = 0.0
    /// 下一个时间label
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        return label
    }()
    /// 翻转动画label
    private lazy var foldLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        return label
    }()
    /// 下一个时间label
    private lazy var nextLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
    /// 放置label的容器
    private lazy var labelContainer: UIView = {
        let labelContainer = UIView()
        return labelContainer
    }()
    /// 刷新UI工具
    private lazy var link: CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(updateAnimateLabel))
        return link
    }()
    var attributes: AppWidgetAttributes = AppWidgetAttributes() {
        didSet {
            /// fix
            timeLabel.textColor = attributes.labelStyle.textColor
            timeLabel.font = attributes.labelStyle.font
            timeLabel.textAlignment = attributes.labelStyle.alignment
            timeLabel.backgroundColor = attributes.labelStyle.backgroundColor

            foldLabel.textColor = attributes.labelStyle.textColor
            foldLabel.font = attributes.labelStyle.font
            foldLabel.textAlignment = attributes.labelStyle.alignment
            foldLabel.backgroundColor = attributes.labelStyle.backgroundColor

            nextLabel.textColor = attributes.labelStyle.textColor
            nextLabel.font = attributes.labelStyle.font
            nextLabel.textAlignment = attributes.labelStyle.alignment
            nextLabel.backgroundColor = attributes.labelStyle.backgroundColor
        }
    }
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 布局尺寸必须在 layoutSubViews 中, 否则获取的 size 不正确 **/
    override func layoutSubviews() {
        super.layoutSubviews()
        labelContainer.frame = self.bounds
        timeLabel.frame = labelContainer.bounds
        nextLabel.frame = labelContainer.bounds
        foldLabel.frame = labelContainer.bounds
    }
}

extension AppFlipClockLabel {
    func update(_ time: Int, next: Int) {
        timeLabel.text = "\(time)"
        foldLabel.text = "\(time)"
        nextLabel.text = "\(next)"
        nextLabel.layer.transform = nextLabelStartTransform()
        nextLabel.isHidden = true
        animateValue = 0.0
        start()
    }
}
private extension AppFlipClockLabel {
    func setupUI() {
        addSubview(labelContainer)
        labelContainer.addSubview(timeLabel)
        labelContainer.addSubview(nextLabel)
        labelContainer.addSubview(foldLabel)
    }
    /// 下一个label开始动画 默认label起始角度
    ///
    /// - Returns: CATransform3D
    private func nextLabelStartTransform() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat.leastNormalMagnitude
        transform = CATransform3DRotate(transform, CGFloat(.pi * Double(kNextLabelStartValue)), -1, 0, 0)
        return transform
    }
    /// 更新动画label
    @objc private func updateAnimateLabel() {
        animateValue += 2 / 60.0
        if animateValue >= 1 {
            stop()
            return
        }
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat.leastNormalMagnitude
        // 绕x轴进行翻转
        transform = CATransform3DRotate(transform, .pi * animateValue, -1, 0, 0)
        if animateValue >= 0.5 {
            // 当翻转到和屏幕垂直时，翻转y和z轴
            transform = CATransform3DRotate(transform, .pi, 0, 0, 1)
            transform = CATransform3DRotate(transform, .pi, 0, 1, 0)
        }
        foldLabel.layer.transform = transform
        // 当翻转到和屏幕垂直时，切换动画label的字
        foldLabel.text = animateValue >= 0.5 ? nextLabel.text : timeLabel.text
        // 当翻转到指定角度时，显示下一秒的时间
        nextLabel.isHidden = animateValue <= kNextLabelStartValue
    }
    /// 开始动画
    private func start() {
        link.add(to: .main, forMode: .common)
    }
    /// 停止动画
    private func stop() {
        link.remove(from: .main, forMode: .common)
    }
}
