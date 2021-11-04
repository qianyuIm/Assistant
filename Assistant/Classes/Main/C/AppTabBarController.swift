//
//  QYTabBarController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import ESTabBarController_swift
import RxTheme
import Localize_Swift

enum AppTabBarSelectedType {
    case widget
    case icons
    case wallpaper
    case more
    typealias RawValue = Int
    var rawValue: RawValue {
        var value : Int
        switch self {
        case .widget:
            value = 0
        case .icons:
            value = 1
        case .wallpaper:
            value = 2
        case .more:
            value = 3
        }
        return value
    }
    init?(rawValue: RawValue) {
        if(rawValue == 0){
            self = .widget
        } else if(rawValue == 1) {
            self = .icons
        } else if(rawValue == 2) {
            self = .wallpaper
        } else {
            self = .more
        }
    }
}

class AppTabBarController: ESTabBarController {
    
    var selectedType: AppTabBarSelectedType  {
        get { return AppTabBarSelectedType(rawValue: selectedIndex)! }
        set(newValue) { selectedIndex = newValue.rawValue }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let widgetsModel = AppWidgetsViewModel()
        let widget = _setController(
            controller: AppWidgetsController(viewModel: widgetsModel),
            title: R.string.localizable.tabbarWidget.key.localized(),
            normalImage: appIconFontIcons.icon_tab_widget.image(size: 24),
            selectImage: appIconFontIcons.icon_tab_widget.image(size: 24))
        
        let iconsViewModel = AppIconsViewModel()
        let icons = _setController(
            controller: AppIconsController(viewModel: iconsViewModel),
            title: R.string.localizable.tabbarIcons.key.localized(),
            normalImage: appIconFontIcons.icon_tab_icons.image(size: 24),
            selectImage: appIconFontIcons.icon_tab_icons.image(size: 24))
        
        let wallpaperViewModel = AppWallpaperViewModel()
        let wallpaper = _setController(
            controller: AppWallpaperController(viewModel: wallpaperViewModel),
            title: R.string.localizable.tabbarWallpaper.key.localized(),
            normalImage: appIconFontIcons.icon_tab_wallpaper.image(size: 24),
            selectImage: appIconFontIcons.icon_tab_wallpaper.image(size: 24))
        
        let moreViewModel = AppMoreViewModel()
        let more = _setController(
            controller: AppMoreController(viewModel: moreViewModel),
            title: R.string.localizable.tabbarMore.key.localized(),
            normalImage: appIconFontIcons.icon_tab_more.image(size: 24),
            selectImage: appIconFontIcons.icon_tab_more.image(size: 24))
        
        
        self.viewControllers = [widget, icons, wallpaper, more]
        bindTheme()
        selectedType = .widget
        
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
        else { return }
        
        _updateTheme()
    }
}

private extension AppTabBarController {
    func bindTheme() {
        
        tabBar.theme.barTintColor = appThemeProvider.attribute {
            $0.tabbarTheme.barTintColor
        }
        
    }
    func _updateTheme() {
        guard #available(iOS 12.0, *) else { return }
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            QYLogger.debug("切换到明亮模式")
            appThemeProvider.type.switchLight()
        case .dark:
            QYLogger.debug("切换到暗黑模式")
            appThemeProvider.type.switchDark()
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    func _setController(controller: AppBaseVMController,
                        title: String,
                        normalImage: UIImage?,
                        selectImage: UIImage?) -> AppNavigationController {
        
        controller.tabBarItem = ESTabBarItem(AppTabBarItemContentView(), title: title, image: normalImage, selectedImage: selectImage)
        let na = AppNavigationController(rootViewController: controller)
        return na
    }
    
}
