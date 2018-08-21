//
//  User.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-20.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import Firebase
import FirebaseAuth
import CoreLocation
import FirebaseFirestore

var mainUserInstance: MainUser!

class MainUser: GlobalUser {
    
    private var authHandle: AuthStateDidChangeListenerHandle?
    
    private var FIRUser = Auth.auth().currentUser!
    var address: Address?
    var location: GeoPoint? {
        didSet {
            notifyDidUpdateLocation()
        }
    }
    var place: CLPlacemark? {
        willSet(newPlace) {
            guard let newLocation = newPlace?.location, let lastLocation = self.place?.location else { return }
            if newLocation.horizontalAccuracy <= lastLocation.horizontalAccuracy {
                return
            }
        }
        didSet {
            updateUserLocation(place: place!)
        }
    }
    var photo: UIImage? {
        didSet {
            uploadPhoto()
        }
    }
    override init() {
        super.init()
        
        authHandle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            print(auth)
            if let user = user {
                print("User logged in: \(user.uid)")
                self.uid = user.uid
                self.getMainInformation(uid: user.uid)
            }
        }
    }
    
    // init main user datas and start fetching location
    func getMainInformation(uid: String) {
        
        MenuInstance.startLoadingAnimation()
        
        DatabaseService.shared.getUserInformation(uid: uid) { doc in
            guard let information = doc else { print("[Error] while unwrapping main user information"); return }
            self.initMainInformation(document: information)
            
            LocationService.shared.startUpdatingLocation()
        }
    }
    
    private func initMainInformation(document: DocumentSnapshot) {
        
        guard let data = document.data() else {
            print("Missing user information during initialization.")
            return
        }
        
        self.uid = document.documentID
        self.publicName = (data["publicName"] as? String)!
        self.pushID = (data["pushID"] as? String)!
        self.contacts = (data["contacts"] as? [String : String])!
        
        let name = data["name"] as? [String:String]
        self.firstName = (name!["firstName"])!
        self.lastName = (name!["lastName"])!
        
        self.notifyDidUpdateUserInformation()
    }
    
    private func updateUserLocation(place: CLPlacemark) {
        
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
            print("[Error] unwrapping values to update location")
        }
    }
    
    private func uploadPhoto() {
        if let image = photo {
            guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
            StorageService.shared.uploadUserPicture(imageData: imageData, uid: uid)
        }
    }
    
    func notifyDidUpdateLocation() {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateLocation"), object: nil, userInfo: nil)
        print("Did update location.")
    }
    
    func notifyDidUpdateUserInformation() {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateUserInformation"), object: nil, userInfo: nil)
        print("Did update user information.")
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
