//
//  Building.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 24..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import MapKit

class Building {

    let longitude:Double
    let latitude:Double
    let radius:Double
    let identifier:String
    
    init(longitude: Double, latitude: Double, radius: Double, identifier: String) {
        self.longitude = longitude
        self.latitude = latitude
        self.radius = radius
        self.identifier = identifier
    }
}
