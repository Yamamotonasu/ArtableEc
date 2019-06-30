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
        // Do any additional setup after loading the view.
//        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
//        present(controller, animated: true, completion: nil)
    }
    

    
    /// ページをロードする度に呼ばれる
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            loginOutBtn.title = "Logout"
        } else {
            loginOutBtn.title = "Login"
        }
    }


    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                presentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            presentLoginController()
        }
        
    }
    
}

