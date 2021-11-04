//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import SnapKit

class AppWidgetsController: AppBaseVMController {
    
    lazy var addItem: UIBarButtonItem = {
        let image = appIconFontIcons.icon_tab_widget.image(size: 24,foregroundColor: UIColor.orange)
        let item = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(handleAddAction(_:event:)))
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let themeSender = UIButton(type: .system)
        themeSender.setTitle("更换皮肤", for: .normal)
        view.addSubview(themeSender)
        themeSender.rx.tap.subscribe (onNext: { () in
            appThemeProvider.type.toggled()
        }).disposed(by: rx.disposeBag)
        
        let alertSender = UIButton(type: .system)
        alertSender.setTitle("弹出普通弹窗", for: .normal)
        view.addSubview(alertSender)
        alertSender.rx.tap.subscribe (onNext: { () in
//            QYAlert.alert(title: "我是标题", message: "我是文本", doneContent: .init(title: "确定", action: {
//
//            }), cancelContent: .init(title: "取消", action: {
//
//            }))
            QYAlert.alert(title: "我是标题", message: "我是文本", doneContent: nil, cancelContent: .init(title: "取消", action: {
                
            }))
        
        }).disposed(by: rx.disposeBag)
        
        
        let privacyPolicySender = UIButton(type: .system)
        privacyPolicySender.setTitle("弹出隐私弹窗", for: .normal)
        view.addSubview(privacyPolicySender)
        privacyPolicySender.rx.tap.subscribe (onNext: { () in
            QYAlert.alertPrivacyPolicy()
        }).disposed(by: rx.disposeBag)
        
        themeSender.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
        }
        alertSender.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(themeSender.snp.bottom).offset(40)
        }
        privacyPolicySender.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(alertSender.snp.bottom).offset(40)
        }
        self.navigationItem.leftBarButtonItem = addItem
        self.navigationItem.title = "说点什么好呢"
    }
    @objc func handleAddAction(_ sender: AnyObject, event: UIEvent) {
        
    }
}
