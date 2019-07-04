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
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text else {
            simpleAlert(title: "エラー", msg: "メールアドレスを入力してください。")
            return
        }
        guard let password = passTxt.text else {
            simpleAlert(title: "エラー", msg: "パスワードを入力してください。")
            return
        }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                self.activityIndicator.stopAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    /// create new userは必要ない
    
    
    @IBAction func guestClicked(_ sender: Any) {
        
    }
}
