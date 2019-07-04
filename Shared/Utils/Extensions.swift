//
//  Extensions.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/30.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/// Stringプロトコルを拡張してisNotEmptyを実装
extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension UIViewController {

//        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "分かったよ。", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
