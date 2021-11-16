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
        
        let secondBtn = UIButton(type: .custom)
        secondBtn.setTitleColor(.red, for: .normal)
        secondBtn.setTitle("123", for: .normal)
        view.addSubview(secondBtn)
        secondBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        // Do any additional setup after loading the view.
        let timer = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
            .map{countDownSeconds - $0}
            .filter{ $0 >= 0 }
            .asDriver(onErrorJustReturn: 0)
        
        let second = secondBtn.rx.tap
            .flatMapLatest { _ -> Driver<Int> in
                return timer
            }
        
        let sendCodeButtonText = second.map { [weak self] (e) -> String in
            secondBtn.isEnabled = (e == 0 ? true : false)
            return (e == 0 ? "发送验证码":"\(e)s")
        }
        
        sendCodeButtonText.bind(to: secondBtn.rx.title(for: .normal)).disposed(by: rx.disposeBag)
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
