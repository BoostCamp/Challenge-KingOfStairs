//
//  User.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 23..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let name: String!
    var userImage: UIImage?
    var kclPoint: Int?
    var userComment: String?
    var place: String?
    
    init(name: String, userImage: UIImage, kclPoint: Int, userComment: String, place: String) {
        self.name = name
        self.userImage = userImage
        self.kclPoint = kclPoint
        self.userComment = userComment
        self.place = place
    }
}
