//
//  CategoryCell.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/05.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImg.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category) {
        categoryLbl.text = category.name
        if let url = URL(string: category.imgUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            categoryImg.kf.indicatorType = .activity
            categoryImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }

}
