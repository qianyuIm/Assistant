//
//  UIBarButtonItemExtensions.swift
//  ios_app
//
//  Created by cyd on 2021/10/29.
//

import Foundation
import UIKit
enum BarButtonItemPosition {
    case left
    case right
}

extension AppExtensionWrapper where Base: UIBarButtonItem {
    
//    static func barButtonItem(position: BarButtonItemPosition,
//                              image: UIImage?,
//                              target: Any?,
//                              action: Selector) -> UIBarButtonItem {
//        let sender = UIButton(type: .custom)
//        sender.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        sender.setImage(image, for: .normal)
//        sender.addTarget(target, action: action, for: .touchUpInside)
//        switch position {
//        case .left:
//            sender.contentEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 12)
//            break
//        case .right:
//            sender.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
//            break
//        }
//        let item = UIBarButtonItem(customView: sender)
//        return item
//    }
}
