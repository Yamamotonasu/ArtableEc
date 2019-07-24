//
//  ProductsVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/06.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController, ProductCellDelegate {
    
    
    // Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // variable
    var products = [Product]()
    var category: Category!
    var listener: ListenerRegistration!
    var db : Firestore!
    var showFavorites = false

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
        setupQuery()
    }
    
    /// 変更が加わった時
    func setupQuery() {
        var reference: Query!
        if showFavorites {
            // collectionでtable指定、documentで絞り込み、更にcollectionでテーブル絞り込み
            reference = db.collection("users").document(UserService.user.id).collection("favorites")
        } else {
            reference = db.products(category: category.id)
        }
        
        /// firestoreのproductscollectionを監視する
        /// categoryのidとproductフィールドのcategoryが同じものを表示する
        listener = reference.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                    
                }
            })
        })
    }
    
    /// 画像がお気に入りされたあとの処理(delegateの関数)
    func productFavorited(product: Product) {
        UserService.favoriteSelected(product: product)
        // 更新された行をreloadする為にproductが最初に現れるindex番号を探す、見つからなければ処理を終了する
        guard let index = products.firstIndex(of: product) else { return }
        // 上で探した行のindex番号を取得してtableViewの特定の行をreloadする
        // reloadするのは複数行指定する事も可能
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
}

extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    
    /// 変更が加わった時
    func onDocumentAdded(change: DocumentChange, product: Product) {
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }
    
    func onDocumentModified(change: DocumentChange, product: Product) {
        if change.oldIndex == change.newIndex {
            /// Item changed, but remained in the same position
            let index = Int(change.newIndex)
            products[index] = product
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            /// Item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at:newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    /// cellにIdentifierを設定しそれをdequeueReusableCellに指定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row], delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    /// cellの数を登録する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        let selectedProduct = products[indexPath.row]
        vc.product = selectedProduct
        /// モーダルを出現させる処理
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    /// cellの高さを指定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
