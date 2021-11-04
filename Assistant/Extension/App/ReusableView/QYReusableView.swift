//
//  ReusableView.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit

protocol QYReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension QYReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}
protocol QYNibLoadableView {
   static var defaultReuseNibName: String { get }
}
extension QYNibLoadableView where Self: UIView{
    static var defaultReuseNibName: String {
        return String(describing: self)
    }
    static func create(viewIndex: Int = 0,
                       owner: Any? = nil,
                       options:[AnyHashable: Any]? = nil) -> Self {
        let bundle = Bundle(for: Self.self)
        
        guard let nib = bundle.loadNibNamed(Self.defaultReuseNibName, owner: owner, options: options as? [UINib.OptionsKey : Any]) else {
            fatalError("nib file \(Self.defaultReuseNibName) is missing")
        }
        guard let view = nib[viewIndex] as? Self else {
            fatalError("Could not instantiate \(Self.self) from nib -- have you conformed to the NibLoadable protocol?")
        }
        return view
    }
}
extension UITableViewCell: QYReusableView { }
extension UICollectionReusableView: QYReusableView { }
extension UITableViewHeaderFooterView: QYReusableView { }
