//
//  SmallWidgetController.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit
import JXPagingView

class SmallWidgetController: AppBaseCollectionVMController {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: JXPagingViewListViewDelegate
extension SmallWidgetController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return view
    }
    
    func listScrollView() -> UIScrollView {
        return collectionView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
}
