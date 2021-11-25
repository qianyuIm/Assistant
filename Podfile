platform :ios, '14.0'
inhibit_all_warnings!
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

def oc_pods
  # 定位SDK
  pod 'AMapLocation', '~> 2.7.0'
  pod 'AMapSearch', '~> 7.9.0'
  # 极光
  pod 'JCore', '~> 2.7.1'
  pod 'JPush', '~> 4.3.6'
  pod 'JMLink', '~> 2.1.5'
  pod 'MJRefresh', '~> 3.4.3'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDWebImageWebPCoder', '~> 0.8.4'
  pod 'SDWebImageFLPlugin', '~> 0.5.0'
  pod 'HBDNavigationBar','~> 1.8.1'
  pod 'XHLaunchAd', '~> 3.9.12'
  # debug tool
  pod 'MLeaksFinder', :git => "https://github.com/Tencent/MLeaksFinder.git", :configurations => ['Debug']
  # debug tool
  pod 'FLEX', '~> 4.2.2',:configurations => ['Debug']
end

def swift_pods
  pod 'RxReachability', '~> 1.2.1'
  pod 'NSObject+Rx', '~> 5.2.2'
  pod 'RxActivityIndicator', '~> 2.0.0'
  pod 'RxDataSources', '~> 5.0.0'
  pod 'RxTheme', '~> 6.0.0'
  pod 'Moya/RxSwift', '~> 15.0.0'
  # tabbar
  pod "ESTabBarController-swift", '~> 2.8.0'
  # 字体
  pod 'EFIconFont', '~> 1.2.0'
  # layout
  pod 'SnapKit', '~> 5.0.1'
  pod 'AutoInch', '~> 2.4.0'
  # 资源管理
  pod 'R.swift', '~> 5.4.0'
  pod 'Localize-Swift', '~> 3.2.0'
  pod 'SwiftLint', '~> 0.45.0'
  # debug log
  pod 'SwiftyBeaver', '~> 1.9.5'
  # UserDefaults
  pod 'SwiftyUserDefaults', '~> 5.3.0'
  # alert
  pod 'SwiftEntryKit', '~> 2.0.0'
  pod 'Toaster', '~> 2.3.0'
  pod 'HandyJSON', '~> 5.0.2'
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  # 富文本
  pod 'SwiftRichString', '~> 3.7.2'
  pod 'AttributedString', '~> 2.2.0'
  # Router
  pod 'URLNavigator', '~> 2.3.0'
  pod 'Hero', '~> 1.6.1'
  pod 'PanModal', '~> 1.2.7'
  pod 'CHIPageControl', '~> 0.2'
  pod 'JXSegmentedView', '~> 1.2.7'
  pod 'JXPagingView/Paging', '~> 2.1.1'
  pod 'BetterSegmentedControl', '~> 2.0.1'
  pod 'SwiftDate', '~> 6.3.1'
  pod 'SPPermissions', '~> 6.7.1'
  pod 'M13Checkbox', '~> 3.4.0'
  # 定时器
  pod 'Schedule', '~> 2.1.0'
  # 流量监控
#  pod 'TrafficPolice', '~> 1.1'
  # db
  pod 'GRDB.swift', '~> 5.12.0'
  #
  pod 'MultiProgressView', '~> 1.3.0'
end


target 'Assistant' do
  oc_pods
  swift_pods
end

target 'WidgetExtensionExtension' do
  pod 'Localize-Swift', '~> 3.2.0'
  pod 'AutoInch', '~> 2.4.0'
  pod 'SwiftyUserDefaults', '~> 5.3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
