//
//  AddEditProductsVC.swift
//  ArdableAdmin
//
//  Created by 山本裕太 on 2019/07/15.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class AddEditProductsVC: UIViewController {
    /// outlet
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var productPriceTxt: UITextField!
    @IBOutlet weak var productDescTxt: UITextView!
    @IBOutlet weak var productImgView: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: RoundedButton!
    
    
    /// variable
    var selectedCategory : Category!
    var productToEdit : Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
    }
    

}
