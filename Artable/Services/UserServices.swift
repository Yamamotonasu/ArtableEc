//
//  UserServices.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/21.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    // MARK: - Variables
    var user = User()
    var favorites = [Product]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener : ListenerRegistration? = nil
    var favsListener : ListenerRegistration? = nil
    var isGuest : Bool {
        // 現在のユーザーが存在すればtrueを返す
        guard let authUser = auth.currentUser else {
            return true
        }
        
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        // 現在ログインしているユーザーをfirestoreから参照する
        let userRef = db.collection("users").document(authUser.uid)
        
        userListener = userRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print(self.user)
        })
        
        // ref favorite
        let favsRef = userRef.collection("favorites")
        
        favsListener = favsRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Product.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
        favorites.removeAll()
    }
}
