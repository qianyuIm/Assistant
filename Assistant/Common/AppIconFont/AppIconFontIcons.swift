/// @author:  qy
/// @date: 2021-11-04 15:40:40
/// @description  代码由程序自动生成。请不要对此文件做任何修改。

import EFIconFont

let appIconFontIcons = EFIconFont.iconFontIcons

extension EFIconFont {

    static let iconFontIcons = AppIconFontIcons.self
}

extension AppIconFontIcons: EFIconFontCaseIterableProtocol {

    public static var name: String {
        return "iconfont"
    }

    public var unicode: String {
        return self.rawValue
    }
}


enum AppIconFontIcons: String {
        case icon_tab_more = "\u{e867}"
case icon_placeholder_404 = "\u{e638}"
case icon_placeholder_empty = "\u{e6b2}"
case icon_placeholder_unconnected = "\u{e6b3}"
case icon_placeholder_unauthorized = "\u{e620}"
case icon_tab_icons = "\u{e627}"
case icon_tab_wallpaper = "\u{e713}"
case icon_tab_widget = "\u{e821}"
    }