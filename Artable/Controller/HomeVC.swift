//
//  ViewController.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/29.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    // @outlets
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    /// インスタンス化した時一度だけよばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously{ (result, error) in
                if let error = error {
                    self.handleFireAuthError(error: error)
                }
            }
        }
    }
    

    
    /// ページをロードする度に呼ばれる
    override func viewDidAppear(_ animated: Bool) {
        /// 認証状態のユーザーが存在するかつuserが匿名ではない
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutBtn.title = "Logout"
        } else {
            loginOutBtn.title = "Login"
        }
    }


    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        /// 第一引数に遷移させたいコントローラ名、completionはcallback
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        self.handleFireAuthError(error: error)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch {
                self.handleFireAuthError(error: error)
                debugPrint(error)
            }
        }
//        if let _ = Auth.auth().currentUser {
//            do {
////                try Auth.auth().signOut()
//                presentLoginController()
//            } catch {
//                debugPrint(error.localizedDescription)
//            }
//        } else {
//            presentLoginController()
//        }
        
    }
    
}

