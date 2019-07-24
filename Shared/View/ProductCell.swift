//
//  ProductCell.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/06.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Kingfisher

// delegateでviewControllerに何をするか指示をする
// 移譲する側でこのdelegateを適応させる(この場合はproduct view controller)
protocol ProductCellDelegate: class {
    // いいねする関数のフォーマト
    func productFavorited(product: Product)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImg: RoundedImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    // weakをつけるとProtocol先でclassを継承させる必要がある。
    // 循環参照を防ぐ役割がある。
    weak var delegate: ProductCellDelegate?
    
    private var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 内部引数delegateに移譲する際に使用するdelegateを登録しておく
    func configureCell(product: Product, delegate: ProductCellDelegate) {
        
        self.product = product
        self.delegate = delegate
        
        productTitle.text = product.name
        
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: AppImages.PlaceHolder)
            productImg.kf.indicatorType = .activity
            // アニメーション秒数
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            productImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        // お気に入り登録されていなかったら空の星マークをつける。
        if UserService.favorites.contains(product) {
            favoriteBtn.setImage(UIImage(named: AppImages.FilledStar), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: AppImages.EmptyStar), for: .normal)
        }
    }

    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    // 星をクリックした時星の画像が変わる。ViewControllerに処理を移譲する
    @IBAction func favoriteClicked(_ sender: Any) {
        delegate?.productFavorited(product: product)
    }
    
}
