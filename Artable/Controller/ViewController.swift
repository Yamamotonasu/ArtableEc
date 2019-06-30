//
//  ViewController.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/29.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
//        present(controller, animated: true, completion: nil)
    }
    
    /// 最初のビューの場合はこっちに書く必要がある？
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }


}

