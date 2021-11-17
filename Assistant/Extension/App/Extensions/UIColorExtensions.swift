//
//  UIColorExtensions.swift
//  ios_app
//
//  Created by cyd on 2021/11/3.
//

import UIKit

extension AppExtensionWrapper where Base == UIColor {
    static func color(red: Int,
                      green: Int,
                      blue: Int,
                      transparency: CGFloat = 1) -> UIColor? {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    /// hexString ->  #ff5ad2db ,EDE7F6,
    /// 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..)
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: #ff5ad2db
    ///   ,EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: optional transparency value (default is 1).
     static func color(hexString: String,
                       transparency: CGFloat = 1,
                       defaultColor: UIColor = .clear) -> UIColor {
        var string = ""
        if hexString.count == 9 && hexString.lowercased().hasPrefix("#ff") {
            string = String(hexString[hexString.index(hexString.startIndex, offsetBy: 3)...])
        } else if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return defaultColor }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        return self.color(red: red, green: green, blue: blue, transparency: trans) ?? defaultColor
    }
}
