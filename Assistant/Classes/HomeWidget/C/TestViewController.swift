//
//  TestViewController.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var clockView: SmileClockContainerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        clockView.bgImage = R.image.icon_widget_bg_32()
        clockView.hourHandImage = R.image.icon_analog_clock_hour_0()
        clockView.secHandImage = R.image.icon_analog_clock_second_0()
        clockView.minHandImage = R.image.icon_analog_clock_minute_0()
        clockView.updateClockView()
    }
}
