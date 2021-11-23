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
    }
    func updateSummary(_ summary: TrafficSummary) {
        let systemUptime = AppUtility.systemUptime()
        timeLabel.text = "\(systemUptime.month)月\(systemUptime.day) - 至今"
        totalLabel.text = (summary.wwan.origin + summary.wifi.origin).total.double.unitString
        wwanTotalLabel.text = summary.wwan.origin.total.double.unitString
        wifiTotalLabel.text = summary.wifi.origin.total.double.unitString
    }
}
extension AppSmallFlowView: MultiProgressViewDelegate {}

extension AppSmallFlowView: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
      return 1
    }
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        return ProgressViewSection()
    }
}
