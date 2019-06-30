//
//  RegisterVC.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/30.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Firebase


/// UITextViewDelegateでtext areaの変更を検知することができる
class RegisterVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    /// グルグル
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// password check image(default non display)
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 第一引数にtextfield
        *   第二引数に入力される度に呼ばれる関数、
        *   第三引数にUIControlで定義されているイベントを引数と*して挿入
        **/
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    /// addTargetでTextFieldに入力される度に実行される関数に指定
    @objc private func textFieldDidChange(_ textField: UITextField) {
        /// パスワードtextがnilだったら以下の処理を実行しない
        guard let passTxt = passwordTxt.text else { return }
        
        /// もしテキストフィールドに入力が始まったら
        if textField == confirmPassTxt {
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            /// もしパスワードtextが空の場合imgとpasswordConfirmのテキストを消す
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        /// text fieldの値がパスワードに合っていれば、チェックマークを緑にする
        if passwordTxt.text == confirmPassTxt.text {
            passCheckImg.image = UIImage(named: AppImages.GreenCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.GreenCheck)
        } else {
            passCheckImg.image = UIImage(named: AppImages.RedCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.RedCheck)
        }
        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        /// emailと名前とパスワードが設定されていなければクリックしてもreturnを返す
        guard let email = emailTxt.text else { return }
        guard let username = usernameTxt.text, !username.isEmpty else { return }
        guard let password = passwordTxt.text, !password.isEmpty else { return }
        
        activityIndicator.startAnimating()
        /// クリックするとユーザーが作成される。
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            /// errroが起きるとここで処理が終了する
            if let error = error {
                debugPrint(error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
//            guard let user = authResult?.user else { return }
        }
    }
}
