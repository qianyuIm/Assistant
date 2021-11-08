//
//  AppAddShellModel.swift
//  Assistant
//
//  Created by 丁帅 on 2021/11/7.
//

import Foundation
/// icon_shell_6s
/// iphone6s
/// 金色
/// 1
class AppAddShellModel {
    var image: String
    var title: String
    var colors: [String]
    var colorIndex: Int

    init(image: String,
         title: String,
         colors: [String],
         colorIndex: Int) {
        self.image = image
        self.title = title
        self.colors = colors
        self.colorIndex = colorIndex
    }
    var shellImage: String {
        return image + "\(colorIndex)"
    }
}
