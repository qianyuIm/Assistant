//
//  QYBorderButton.swift
//  QianyuIm
//
//  Created by cyd on 2020/7/17.
//  Copyright © 2020 qianyuIm. All rights reserved.
//

import UIKit


class QYBorderButton: QYButton {
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    var cornerRadius: CGFloat = -1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if self.cornerRadius != QYConfig.Value.undefinedValue {
            self.layer.cornerRadius = self.cornerRadius
        } else {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
}
