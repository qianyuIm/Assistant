//
//  AppColorSwatch.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//

import UIKit
enum AppColorSwatch: Int {
    case netease, didi, weChat, fish, quark

    static let allValues = [netease, didi, weChat, fish, quark]

    var color: UIColor {
        switch self {
        case .netease: return UIColor.app.color(hexString: "#F83245")
        case .didi: return UIColor.app.color(hexString: "#FF7B24")
        case .weChat: return UIColor.app.color(hexString: "#03dc6a")
        case .fish: return UIColor.app.color(hexString: "#dda600")
        case .quark: return UIColor.app.color(hexString: "#9565b1")
        }
    }

    var colorDark: UIColor {
        switch self {
        case .netease: return UIColor.app.color(hexString: "#bd0618")
        case .didi: return UIColor.app.color(hexString: "#EC5D00")
        case .weChat: return UIColor.app.color(hexString: "#03a04d")
        case .fish: return UIColor.app.color(hexString: "#a17900")
        case .quark: return UIColor.app.color(hexString: "#6e4486")
        }
    }

    var title: String {
        switch self {
        case .netease: return "网易红"
        case .didi: return "滴滴橙"
        case .weChat: return "微信绿"
        case .fish: return "闲鱼黄"
        case .quark: return "夸克紫"
        }
    }
}
