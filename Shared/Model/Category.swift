//
//  Category.swift
//  Artable
//
//  Created by 山本裕太 on 2019/07/05.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    init(
        name: String,
        id: String,
        imgUrl: String,
        isActive: Bool = true,
        timeStamp: Timestamp) {
        self.name = name
        self.id = id
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    
    static func modelToData(category: Category) -> [String: Any] {
        let data : [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "imageUrl" : category.imgUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp
        ]
        
        return data
    }
}
