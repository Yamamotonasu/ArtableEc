//
//  RegisterVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/30.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func registerClicked(_ sender: Any) {
        /// emailと名前とパスワードが設定されていなければクリックしてもreturnを返す
        guard let email = emailTxt.text else { return }
        guard let username = usernameTxt.text, !username.isEmpty else { return }
        guard let password = passwordTxt.text, !password.isEmpty else { return }
        /// クリックするとユーザーが作成される。
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            /// errroが起きるとここで処理が終了する
            if let error = error {
                debugPrint(error)
                return
            }
            print("successfully registered new user")
//            guard let user = authResult?.user else { return }
        }
    }
}
