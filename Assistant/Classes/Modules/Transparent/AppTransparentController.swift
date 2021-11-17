//
//  TransparentConfigController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit

class AppTransparentController: AppBaseVMController {
    lazy var guideItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: R.image.icon_transparent_guide(), style: .plain, target: self, action: #selector(handleGuideAction(_:event:)))
        return item
    }()
    lazy var transparentView: UIView = {
        let view = UIView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func setupUI() {
         super.setupUI()
        navigationItem.rightBarButtonItem = guideItem
        navigationItem.title = R.string.transparent.navigationTitle.key.app.transparentLocalized()
    }
    @objc func handleGuideAction(_ sender: AnyObject, event: UIEvent) {}
}
