//
//  NearbyPlaces.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct NearbyPlace {

    var ID: String
    var name: String
    var status: Bool
    var coordinate: CLLocationCoordinate2D {
        didSet {
            guard let location = mainUserInstance.location  else { print("Main user location not set."); return }
            self.distance = Int(CLLocation(latitude: location.latitude, longitude: location.longitude).distance(from: CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)))
        }
    }
    var description: String?
    var type: String?
    var image: UIImage?
    var distance: Int?
  
    
    init(ID: String, name: String, status: Bool, coordinate: CLLocationCoordinate2D, description: String, type: String, image: UIImage) {
        self.ID = ID
        self.name = name
        self.status = status
        self.coordinate = coordinate
        self.description = description
        self.type = type
        self.image = image
        
        if let location = mainUserInstance.location {
            self.distance = Int(CLLocation(latitude: location.latitude, longitude: location.longitude).distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)))
        }
    }
    
}

