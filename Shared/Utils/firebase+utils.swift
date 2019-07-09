//
//  firebase+utils.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/04.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    var categories: Query {
        return collection("categories").order(by: "timeStamp", descending: true)
    }
}

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        /// firebaseのエラーコードのenumから抽出
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "何かが間違っているよ！", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "分かったよ。", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "このEmailは既に他のアカウントで使われています。他のメールアドレスを使用してください。"
        case .userNotFound:
            return "指定されたユーザーのアカウントは見つかりません。もう一度確認してください。"
        case .userDisabled:
            return "あなたのアカウントは有効ではありません。サポートに問い合わせてみてください。"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "正しいメールアドレスを入力してください。"
        case .networkError:
            return "通信エラーです。もう一度試してみてください。"
        case .weakPassword:
            return "あなたの設定しようとしたパスワードは短すぎます。6文字以上で入力してください。"
        case .wrongPassword:
            return "メールアドレスかパスワードが間違っています。もう一度入力してください。"
        default:
            return "何かが間違っています。"
        }
    }
}
