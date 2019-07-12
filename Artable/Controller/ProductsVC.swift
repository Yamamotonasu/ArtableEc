//
//  ProductsVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/06.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Alamofire

class ProductsVC: UIViewController {
    
    // Outlets
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // variable
    var products = [Product]()
    var category: Category!
    var listener: ListenerRegistration
    var db : Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
    }
    
    func setupQuery() {
        listener = db.products.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded()
                case .modified:
                    self.onDocumentModified()
                case .removed:
                    self.onDocumentRemoved()
                    
                }
            })
        })
    }
}

extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    
    func onDocumentAdded() {
        
    }
    
    func onDocumentModified() {
        
    }
    
    func onDocumentRemoved() {
        
    }
    
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
