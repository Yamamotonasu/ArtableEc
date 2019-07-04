//
//  ForgotPasswordVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/04.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    // outlets

    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty else {
            simpleAlert(title: "エラー", msg: "メールアドレスを入力してください")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
