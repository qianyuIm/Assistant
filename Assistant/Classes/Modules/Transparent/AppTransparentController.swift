//
//  TransparentConfigController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit

class AppTransparentController: AppBaseVMController {
    lazy var guideItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: R.image.icon_transparent_guide(),style: .plain, target: self, action: #selector(handleGuideAction(_:event:)))
        return item
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
         super.setupUI()
        self.navigationItem.rightBarButtonItem = guideItem
    }
    
    @objc func handleGuideAction(_ sender: AnyObject, event: UIEvent) {
        
    }
    
}
