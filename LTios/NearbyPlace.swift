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

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

struct NearbyPlace {

    var ID: String
    var name: String
    var status: Int
    var description: String
    var distance: Int
    var category: String // Could become an enum
    var city: String
    var price: Int // from 1-3; could also be an enum
    var averageRating: Float
    var image: UIImage
    
    var dictionary: [String: Any] {
        return [
            "ID": ID,
            "name": name,
            "status": status,
            "description": description,
            "distance": distance,
            "category": category,
            "city": city,
            "price": price,
            "avgRating": averageRating,
            "image": image
        ]
    }
    
    init(ID: String,
         name: String,
         status: Int,
         description: String,
         distance: Int,
         category: String,
         city: String,
         price: Int,
         averageRating: Float,
         image: UIImage) {
        
        self.ID = ID
        self.name = name
        self.status = status
        self.description = description
        self.distance = distance
        self.category = category
        self.city = city
        self.price = price
        self.averageRating = averageRating
        self.image = image
    }
    
}

extension NearbyPlace: DocumentSerializable {
    
    static let categories = [
        "Brunch", "Burgers", "Coffee", "Deli", "Dim Sum", "Indian", "Italian",
        "Mediterranean", "Mexican", "Pizza", "Ramen", "Sushi"
    ]
    
     init?(dictionary: [String : Any]) {
        
        guard let ID = dictionary["ID"] as? String,
            let name = dictionary["name"] as? String,
            let status = dictionary["status"] as? Int,
            let description = dictionary["description"] as? String,
            let distance = dictionary["distance"] as? Int,
            let category = dictionary["category"] as? String,
            let city = dictionary["city"] as? String,
            let price = dictionary["price"] as? Int,
            let averageRating = dictionary["avgRating"] as? Float,
            let image = dictionary["image"] as? UIImage else { return nil }
        
        self.init(ID: ID,
                  name: name,
                  status: status,
                  description: description,
                  distance: distance,
                  category: category,
                  city: city,
                  price: price,
                  averageRating: averageRating,
                  image: image)
    }
}

