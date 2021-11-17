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
//        flipClockView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: 600, height: 248))
//        }
//        let plan = Plan.every(1.seconds)
//        self.timer = plan.do(mode: .common) { task in
//            self.flipClockView.attributes = attributes
//            self.flipClockView.dateSource = Date()
//        }
        // 创建Timer对象
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
//        self.timer = plan.do(queue: .main) {
//
//        }
    }
    /// 定时器的监听事件
    @objc private func updateTimeLabel() {
        let timeDate = Date()
        let attributes = AppWidgetAttributes()
        flipClockView.attributes = attributes
        flipClockView.dateSource = timeDate
    }
}
