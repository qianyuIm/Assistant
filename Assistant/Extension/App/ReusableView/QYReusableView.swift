//
//  ReusableView.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit

protocol AppReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension AppReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

protocol AppNibLoadableView {
   static var defaultReuseNibName: String { get }
}

extension AppNibLoadableView where Self: UIView {
    static var defaultReuseNibName: String {
        return String(describing: self)
    }
    static func create(viewIndex: Int = 0,
                       owner: Any? = nil,
                       options: [AnyHashable: Any]? = nil) -> Self {
        let bundle = Bundle(for: Self.self)
        guard let nib = bundle.loadNibNamed(Self.defaultReuseNibName, owner: owner, options: options as? [UINib.OptionsKey: Any]) else {
            fatalError("nib file \(Self.defaultReuseNibName) is missing")
        }
        guard let view = nib[viewIndex] as? Self else {
            fatalError("Could not instantiate \(Self.self) from nib -- have you conformed to the NibLoadable protocol?")
        }
        return view
    }
}
extension UITableViewCell: AppReusableView {}
extension UICollectionReusableView: AppReusableView { }
extension UITableViewHeaderFooterView: AppReusableView { }
