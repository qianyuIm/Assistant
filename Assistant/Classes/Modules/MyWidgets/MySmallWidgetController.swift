//
//  MySmallWidgetController.swift
//  Assistant
//
//  Created by cyd on 2021/11/12.
//

import UIKit
import JXSegmentedView

class MySmallWidgetController: AppBaseCollectionVMController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MySmallWidgetController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
