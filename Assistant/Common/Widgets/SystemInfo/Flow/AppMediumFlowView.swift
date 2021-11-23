//
//  AppMediumFlowView.swift
//  Assistant
//
//  Created by cyd on 2021/11/22.
//

import UIKit
import MultiProgressView

class AppMediumFlowView: UIView, AppNibLoadableView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var wwanSendTotalLabel: UILabel!
    @IBOutlet weak var wwanSendProgressView: MultiProgressView!

    @IBOutlet weak var wwanReceivedTotalLabel: UILabel!
    @IBOutlet weak var wwanReceivedProgressView: MultiProgressView!

    @IBOutlet weak var wifiSendTotalLabel: UILabel!
    @IBOutlet weak var wifiSendProgress: MultiProgressView!

    @IBOutlet weak var wifiReceivedTotalLabel: UILabel!
    @IBOutlet weak var wifiReceivedProgress: MultiProgressView!
    func updateSummary(_ summary: TrafficSummary) {
        totalLabel.text = summary.wifi.origin.total.double.unitString
    }
}
