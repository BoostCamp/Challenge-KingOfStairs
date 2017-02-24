//
//  Badge.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 22..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation

struct Badge {
    let name: String
    let caption: String
    let hint: String
    var activation: Bool
    
    init(name: String, caption: String, hint: String, activation: Bool) {
        self.name = name
        self.caption = caption
        self.hint = hint
        self.activation = activation
    }
}
