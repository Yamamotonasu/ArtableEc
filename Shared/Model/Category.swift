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
}
