//
//  AppWidgetEditController.swift
//  Assistant
//
//  Created by cyd on 2021/11/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AppWidgetEditController: AppBaseVMController {

    lazy var saveSender: UIButton = {
        let sender = UIButton(type: .custom)
        sender.setTitle("保存组件", for: .normal)
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
        view.addSubview(saveSender)
    }
    override func setupConstraints() {
        super.setupConstraints()
        saveSender.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40).auto())
        }
    }
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? AppWidgetEditViewModel else { return }
        navigationItem.title = viewModel.attributes.displayName

        saveSender.rx.tap.subscribe(onNext: { () in
            viewModel.attributes.save()
        }).disposed(by: rx.disposeBag)
    }
    override func setupTheme() {
        super.setupTheme()
    }
}
