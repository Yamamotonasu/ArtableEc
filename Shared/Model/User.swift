//
//  User.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/21.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var username: String
    var stripeId: String
    
    init(id: String = "",
         email: String = "",
         username: String = "",
         stripeId: String = "") {
        self.id = id
        self.email = email
        self.username = username
        self.stripeId = stripeId
    }
    
    // for use
    init(data: [String : Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        username = data["username"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
    }
    
    // for upload
    static func modelToData(user: User) -> [String : Any] {
        let data: [String : Any] = [
            "id" : user.id,
            "email" : user.email,
            "username" : user.username,
            "stripeId" : user.stripeId
        ]
        
        return data
    }
}
