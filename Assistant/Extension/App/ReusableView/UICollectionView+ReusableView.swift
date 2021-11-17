//
//  UICollectionView+QYReusableView.swift
//  QYBaseGeneral
//
//  Created by cyd on 2020/3/13.
//

import UIKit

extension AppExtensionWrapper where Base: UICollectionView {
    func register<T: UICollectionViewCell>(cellClass name: T.Type) {
        self.base.register(T.self,
                           forCellWithReuseIdentifier: name.defaultReuseIdentifier)
    }
    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type) where T: AppNibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseNibName, bundle: bundle)
        self.base.register(nib,
                           forCellWithReuseIdentifier: name.defaultReuseIdentifier)
    }
    func register<T: UICollectionReusableView>(viewClass name: T.Type, forSupplementaryViewOfKind elementKind: String) {
        self.base.register(T.self,
                           forSupplementaryViewOfKind: elementKind,
                           withReuseIdentifier: name.defaultReuseIdentifier)
    }
    func register<T: UICollectionReusableView>(nibWithViewClass name: T.Type, forSupplementaryViewElementOfKind elementKind: String) where T: AppNibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseNibName, bundle: bundle)
        self.base.register(nib,
                           forSupplementaryViewOfKind: elementKind,
                           withReuseIdentifier: name.defaultReuseIdentifier)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.base.dequeueReusableCell(withReuseIdentifier: name.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(name.defaultReuseIdentifier)")
        }
        return cell
    }
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: name.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(name.defaultReuseIdentifier)")
        }
        return cell
    }
}
