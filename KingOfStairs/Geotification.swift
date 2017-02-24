//
//  Geotification.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 21..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct GeoKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let radius = "radius"
    static let identifier = "identifier"
}

class Geotification: NSObject ,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
    }
}
