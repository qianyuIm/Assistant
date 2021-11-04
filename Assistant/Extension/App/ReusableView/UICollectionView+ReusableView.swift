//
//  UICollectionView+QYReusableView.swift
//  QYBaseGeneral
//
//  Created by cyd on 2020/3/13.
//

import UIKit

extension AppExtensionWrapper where Base: UICollectionView {
    
    func register<Cell: UICollectionViewCell>(cellClass name: Cell.Type) {
        self.base.register(Cell.self,
                           forCellWithReuseIdentifier: name.defaultReuseIdentifier)
    }
    func register<Supplementary: UICollectionReusableView>(viewClass name: Supplementary.Type,forSupplementaryViewOfKind elementKind: String) {
        self.base.register(Supplementary.self,
                           forSupplementaryViewOfKind: elementKind,
                           withReuseIdentifier: name.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(cellClass name: Cell.Type,for indexPath: IndexPath) -> Cell {

        guard let cell = self.base.dequeueReusableCell(withReuseIdentifier: name.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<Supplementary: UICollectionReusableView>(ofKind elementKind: String, withClass name: Supplementary.Type, for indexPath: IndexPath) -> Supplementary {
        guard let cell = self.base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: name.defaultReuseIdentifier, for: indexPath) as? Supplementary else {
            fatalError("Could not dequeue supplementary view with identifier: \(name.defaultReuseIdentifier)")
        }
        return cell
    }
}
