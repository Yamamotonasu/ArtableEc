//
//  ProductDetailVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/13.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    /// outlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    /// productを指定
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// textへ代入
        productTitle.text = product.name
        productDescription.text = product.productDescription
        if let url = URL(string: product.imageUrl) {
            productImg.kf.setImage(with: url)
        }
        
        /// formatを指定
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        /// tapを有効にする
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct(_:)))
        /// タップの必要な回数
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func dismissProduct() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCartClicked(_ sender: Any) {
        /// add product to cart
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
