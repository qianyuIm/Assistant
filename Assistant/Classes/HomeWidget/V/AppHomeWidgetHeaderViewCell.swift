//
//  AppHomeWidgetHeaderViewCell.swift
//  Assistant
//
//  Created by cyd on 2021/11/8.
//

import UIKit

class AppHomeWidgetHeaderViewCell: UICollectionViewCell,AppNibLoadableView {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.app.addRoundCorners(.allCorners, radius: 6)
    }
    
    func config(_ item: AppHomeWidgetHeaderItem) {
        imageView.image = UIImage(named: item.imageName)
    }

}
