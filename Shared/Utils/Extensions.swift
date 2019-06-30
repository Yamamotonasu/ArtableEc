//
//  Extensions.swift
//  Artable
//
//  Created by 山本裕太 on 2019/06/30.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

/// Stringプロトコルを拡張してisNotEmptyを実装
extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
