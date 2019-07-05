//
//  ProductsVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/06.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // variable
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product = Product.init(name: "Landscape", id: "kkkkk", category: "nature", price: 24.99, productDescription: "What a lovely landscape", imageUrl: "https://images.unsplash.com/photo-1562256947-e52273ee433a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", timeStamp: Timestamp(), stock: 0, favorite: false)
        
        products.append(product)
        
        tableView.delegate = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
    }
}

extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    /// cellにIdentifierを設定しそれをdequeueReusableCellに指定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    /// cellの高さを指定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
