//
//  User.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-20.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import Firebase
import CoreLocation

var mainUserInstance: MainUser!

class MainUser: GlobalUser {
    
    var FIRUser = Auth.auth().currentUser!
    var address: Address?
    var location: GeoPoint? {
        willSet(newLocation) {
        }
        didSet {
            notifyDidUpdateLocation()
        }
    }
    
    var place: CLPlacemark? {
        didSet {
            updateUserLocation(place: place!)
        }
    }
    
    override init(document: DocumentSnapshot) {
        super.init(document: document)
    }
    
    func updateUserLocation(place: CLPlacemark) {
        
        if let location = place.location,
            let iso = place.isoCountryCode,
            let state = place.administrativeArea,
            let country = place.country,
            let city = place.locality,
            let postalCode = place.postalCode {
            
            self.address = Address(country: country, ISO: iso, city: city, state: state, postalCode: postalCode)
            self.location = GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            DatabaseService.shared.updateUserDatabaseLocation()
            
        } else {
            print("Error while unwrapping values to update location")
        }
    }
    
    func notifyDidUpdateLocation() {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateLocation"), object: nil, userInfo: nil)
        print("Did update location.")
    }
}


struct Address {
    var country: String
    var ISO: String
    var city: String
    var state: String
    var postalCode: String
}

func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.country == rhs.country
        && lhs.ISO == rhs.ISO
        && lhs.city == rhs.city
        && lhs.state == rhs.state
        && lhs.postalCode == rhs.postalCode
}
