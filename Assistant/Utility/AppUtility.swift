//
//  AppUtility.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit

class AppUtility {
    class func copy(with value: String, complete: (() -> Void)? = nil) {
        UIPasteboard.general.string = value
        complete?()
    }
}
