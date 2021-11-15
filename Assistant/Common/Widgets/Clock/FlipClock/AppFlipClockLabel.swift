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
        let nextLabel = UILabel()
        nextLabel.text = "1"
        return nextLabel
    }()
    /// 翻转动画label
    private lazy var foldLabel: UILabel = {
        let foldLabel = UILabel()
        nextLabel.text = "1"
        return foldLabel
    }()
    
    /// 下一个时间label
    private lazy var nextLabel: UILabel = {
        let nextLabel = UILabel()
        nextLabel.text = "1"
        return nextLabel
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
    var attributes: AppWidgetAttributes {
        didSet {
            timeLabel.textColor = attributes.labelStyle.color
            timeLabel.font = attributes.labelStyle.font
            timeLabel.textAlignment = attributes.labelStyle.alignment

            foldLabel.textColor = attributes.labelStyle.color
            foldLabel.font = attributes.labelStyle.font
            foldLabel.textAlignment = attributes.labelStyle.alignment
            
            nextLabel.textColor = attributes.labelStyle.color
            nextLabel.font = attributes.labelStyle.font
            nextLabel.textAlignment = attributes.labelStyle.alignment

        }
    }
    
    init(attributes: AppWidgetAttributes) {
        self.attributes = attributes
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    func configUI() {
        addSubview(labelContainer)
        labelContainer.addSubview(timeLabel)
        labelContainer.addSubview(nextLabel)
        labelContainer.addSubview(foldLabel)
        setupConstraints()
    }
    func setupConstraints() {
        labelContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        timeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        foldLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    /// 下一个label开始动画 默认label起始角度
    ///
    /// - Returns: CATransform3D
    private func nextLabelStartTransform() -> CATransform3D {
        var t: CATransform3D = CATransform3DIdentity
        t.m34 = CGFloat.leastNormalMagnitude
        t = CATransform3DRotate(t, CGFloat(.pi * Double(kNextLabelStartValue)), -1, 0, 0)
        return t
    }
    
    /// 更新动画label
    @objc private func updateAnimateLabel() {
        animateValue += 2 / 60.0
        if animateValue >= 1 {
            stop()
            return
        }
        var t: CATransform3D = CATransform3DIdentity
        t.m34 = CGFloat.leastNormalMagnitude
        
        // 绕x轴进行翻转
        t = CATransform3DRotate(t, .pi * animateValue, -1, 0, 0)
        if animateValue >= 0.5 {
            // 当翻转到和屏幕垂直时，翻转y和z轴
            t = CATransform3DRotate(t, .pi, 0, 0, 1)
            t = CATransform3DRotate(t, .pi, 0, 1, 0)
        }
        foldLabel.layer.transform = t
        
        // 当翻转到和屏幕垂直时，切换动画label的字
        foldLabel.text = animateValue >= 0.5 ? nextLabel.text : timeLabel.text
        
        // 当翻转到指定角度时，显示下一秒的时间
        nextLabel.isHidden = animateValue <= kNextLabelStartValue
    }
    
    /// 开始动画
    private func start() {
        link.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    /// 停止动画
    private func stop() {
        link.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
    }
}
