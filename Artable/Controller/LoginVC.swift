//
//  LoginVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/30.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgetPassClicked(_ sender: Any) {
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text else{ return }
        guard let password = passTxt.text else{ return }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint(error)
                self.activityIndicator.stopAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
            print("login was successful!")
        }
        
    }
    
    /// create new userは必要ない
    
    
    @IBAction func guestClicked(_ sender: Any) {
        
    }
}
