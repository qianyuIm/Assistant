//
//  AppLargeFlowView.swift
//  Assistant
//
//  Created by cyd on 2021/11/22.
//

import UIKit
import MultiProgressView

class AppLargeFlowView: UIView, AppNibLoadableView {
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
    override func awakeFromNib() {
        super.awakeFromNib()
        wwanSendProgressView.lineCap = .round
        wwanReceivedProgressView.lineCap = .round
        wifiSendProgress.lineCap = .round
        wifiReceivedProgress.lineCap = .round
        let trackBackgroundColor = UIColor.app.color(hexString: "323232")
        wwanSendProgressView.trackBackgroundColor = trackBackgroundColor
        wwanReceivedProgressView.trackBackgroundColor = trackBackgroundColor
        wifiSendProgress.trackBackgroundColor = trackBackgroundColor
        wifiReceivedProgress.trackBackgroundColor = trackBackgroundColor
    }
    func updateSummary(_ summary: TrafficSummary) {
        let systemUptime = AppUtility.systemUptime()
        timeLabel.text = "\(systemUptime.month)月\(systemUptime.day) - 至今"
        totalLabel.text = (summary.wwan.origin + summary.wifi.origin).total.double.unitString

        let wwanSent = summary.wwan.origin.sent.double
        let wwanReceived = summary.wwan.origin.received.double
        let wifiSent = summary.wifi.origin.sent.double
        let wifiReceived = summary.wifi.origin.received.double

        wwanSendTotalLabel.text = wwanSent.unitString
        wwanReceivedTotalLabel.text = wwanReceived.unitString
        wifiSendTotalLabel.text = wifiSent.unitString
        wifiReceivedTotalLabel.text = wifiReceived.unitString

        let ((value1, value2), (value3, value4)) = progress(for: wwanSent, wwanReceived: wwanReceived, wifiSent: wifiSent, wifiReceived: wifiReceived)
        wwanSendProgressView.setProgress(section: 0, to: value1)
        wwanReceivedProgressView.setProgress(section: 0, to: value2)
        wifiSendProgress.setProgress(section: 0, to: value3)
        wifiReceivedProgress.setProgress(section: 0, to: value4)
    }
    func progress(for wwanSent: Double,
                  wwanReceived: Double,
                  wifiSent: Double,
                  wifiReceived: Double) -> ((Float, Float), (Float, Float)) {
        let reference = max(wwanSent, wwanReceived, wifiSent, wifiReceived)
        let value1 = wwanSent / reference
        let value2 = wwanReceived / reference
        let value3 = wifiSent / reference
        let value4 = wifiReceived / reference
        return ((Float(value1), Float(value2)), (Float(value3), Float(value4)))
    }
}
extension AppLargeFlowView: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
      return 1
    }
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let sectionView = ProgressViewSection()
        if progressView.tag == 101 {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#FF9A0D")
        } else if progressView.tag == 102 {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#D01845")
        } else if progressView.tag == 103 {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#9DEB12")
        } else {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#5EE0CE")
        }
        return sectionView
    }
}

