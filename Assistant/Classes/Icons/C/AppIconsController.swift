//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import Schedule
import RxSwift
import RxCocoa
import SnapKit

class AppIconsController: AppBaseVMController {
    lazy var clockView: AppClockView = {
        let clockView = AppClockView()
        return clockView
    }()
    var attributes = AppWidgetAttributes.clock(.small)
    lazy var sender: UIButton = {
        let sender = UIButton(type: .custom)
        sender.setTitle("点击", for: .normal)
        sender.setTitleColor(.red, for: .normal)
        return sender
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func setupLanguage() {
        super.setupLanguage()
    }
    override func setupUI() {
        super.setupUI()
        view.addSubview(clockView)
        view.addSubview(sender)
        clockView.attributes = attributes
    }
    override func setupConstraints() {
        super.setupConstraints()
        clockView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 200))
        }
        sender.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(clockView.snp.bottom).offset(30)
        }
    }
    override func bindViewModel() {
        super.bindViewModel()
        sender.rx.tap.subscribe(onNext: { [weak self] () in
            if self?.attributes.clockAttributes.isLimitedHoursShown == true {
                self?.attributes.clockAttributes.isLimitedHoursShown = false
            } else {
                self?.attributes.clockAttributes.isLimitedHoursShown = true
            }
            self?.clockView.attributes = self?.attributes
        }).disposed(by: rx.disposeBag)
    }
}
