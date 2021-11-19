//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import Schedule
import AttributedString

class AppIconsController: AppBaseVMController {
    lazy var flipClockView: AppFlipClockView = {
        let view = AppFlipClockView()
        view.dateSource = Date()
        view.frame = CGRect(x: 40, y: 40, width: 600, height: 400)
        view.backgroundColor = UIColor.orange
        return view
    }()
//    var timer: Schedule.Task?
    /// 定时器
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func setupLanguage() {
        super.setupLanguage()
    }
    override func setupUI() {
        super.setupUI()
        view.addSubview(flipClockView)
    }
    
}
