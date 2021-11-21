//
//  AppWidgetsController.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit
import RxSwift
import RxCocoa

let countDownSeconds: Int = 60

class AppWallpaperController: AppBaseVMController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.red.cgColor
        shapeLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        shapeLayer.position = view.center
        view.layer.addSublayer(shapeLayer)
    }
    override func setupLanguage() {
        super.setupLanguage()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
