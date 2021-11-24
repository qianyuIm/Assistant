//
//  AppSmallFlowView.swift
//  Assistant
//
//  Created by cyd on 2021/11/22.
//

import UIKit
import MultiProgressView
import SwiftDate
class AppSmallFlowView: UIView, AppNibLoadableView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var wwanTotalLabel: UILabel!
    @IBOutlet weak var wwanProgress: MultiProgressView!
    @IBOutlet weak var wifiTotalLabel: UILabel!
    @IBOutlet weak var wifiProgress: MultiProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        wwanProgress.lineCap = .round
        wifiProgress.lineCap = .round
        let trackBackgroundColor = UIColor.app.color(hexString: "323232")
        wwanProgress.trackBackgroundColor = trackBackgroundColor
        wifiProgress.trackBackgroundColor = trackBackgroundColor

    }
    func updateSummary(_ summary: TrafficSummary) {
        let systemUptime = AppUtility.systemUptime()
        timeLabel.text = "\(systemUptime.month)月\(systemUptime.day) - 至今"
        let wwanTotal = summary.wwan.origin.total.double
        let wifiTotal = summary.wifi.origin.total.double
        totalLabel.text = (summary.wwan.origin + summary.wifi.origin).total.double.unitString
        wwanTotalLabel.text = wwanTotal.unitString
        wifiTotalLabel.text = wifiTotal.unitString
        let (wwan, wifi) = progress(for: wwanTotal, wifiTotal: wifiTotal)
        wwanProgress.setProgress(section: 0, to: wwan)
        wifiProgress.setProgress(section: 0, to: wifi)
    }
    func progress(for wwanTotal: Double, wifiTotal: Double) -> (Float, Float) {
        let reference = max(wwanTotal, wifiTotal)
        let wwanProgress = wwanTotal / reference
        let wifiProgress = wifiTotal / reference
        return (Float(wwanProgress), Float(wifiProgress))
    }
}
extension AppSmallFlowView: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
      return 1
    }
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let sectionView = ProgressViewSection()
        QYLogger.debug("progressView => \(progressView)")
        if progressView.tag == 101 {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#D01845")
        } else {
            sectionView.backgroundColor = UIColor.app.color(hexString: "#5EE0CE")
        }
        return sectionView
    }
}
