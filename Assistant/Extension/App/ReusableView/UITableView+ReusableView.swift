//
//  UITableView+QYReusableView.swift
//  QYBaseGeneral
//
//  Created by cyd on 2020/3/13.
//

import UIKit

extension AppExtensionWrapper where Base: UITableView {
    func register<T: UITableViewCell>(cellClass name: T.Type) {
        self.base.register(T.self, forCellReuseIdentifier: name.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type) where T: AppNibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseNibName, bundle: bundle)
        self.base.register(nib, forCellReuseIdentifier: name.defaultReuseIdentifier)
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(viewClass name: T.Type) {
        self.base.register(T.self,
                           forHeaderFooterViewReuseIdentifier: name.defaultReuseIdentifier)
        
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(nibWithViewClass name: T.Type) where T: AppNibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseNibName, bundle: bundle)
        self.base.register(nib, forHeaderFooterViewReuseIdentifier: name.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass name: T.Type,for indexPath: IndexPath) -> T {
        guard let cell = self.base.dequeueReusableCell(withIdentifier: name.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(name.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let view = self.base.dequeueReusableHeaderFooterView(withIdentifier: name.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter view with identifier: \(name.defaultReuseIdentifier)")
        }
        return view
    }
}
