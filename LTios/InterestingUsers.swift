//
//  InterestingUsers.swift
//  LT_Contacts_Manager
//
//  Created by Paul Bénéteau on 01/08/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class InterestingUser: GlobalUser {
    
    var distance: Int!
    var friendsInCommon: [String:String]!
    var location: GeoPoint?
    
    var friendsInCommonNb: Int! {
        get {
            return friendsInCommon.count
        }
    }
    
    override init(document: DocumentSnapshot) {
        super.init(document: document)
        
        guard let data = document.data() else {
            print("Missing user information during initialization.")
            return
        }
        
        self.location = (data["last_location"] as? GeoPoint)!
    }
    
    override init() {
        super.init()
    }
}


// Close users & friends in common > 0
class InterestingUsers {
    
    public static var shared = InterestingUsers()
    
    var db = Firestore.firestore()
    
    let distanceRequiered = 20000
    
    
    // looking for potential friends from local users (distance, friends in common, ...?)
    func getInterestingUsers(nearbyUsers: [InterestingUser], completion: @escaping([InterestingUser]?) -> Void) {
        
        if nearbyUsers.count <= 0 { completion(nil); return }
        
        var interestingUsers = [InterestingUser]()
        
        guard let latitude = mainUserInstance.location?.latitude,
            let longitude = mainUserInstance.location?.longitude else { print("Main user location not set."); return }
        
        let mainUserLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        for user in nearbyUsers {
            
            guard let latitude1 = user.location?.latitude,
                let longitude1 = user.location?.longitude else { print("No location for \(String(describing: user.firstName))."); continue }
            
            let userLocation = CLLocation(latitude: latitude1, longitude: longitude1)
            
            // if user is nearby
            let distance = LocationService.shared.getDistanceBetweenLocations(location1: mainUserLocation, location2: userLocation)
            if !isCloseEnough(distance: distance) { continue }
            
            guard let userContacts = user.contacts else { print("\(String(describing: user.firstName)) does not have any contact."); continue }
            
            // and if friends in common...
            if let interestingUser = user as? InterestingUser {
                
                guard let friendsInCommon = ContactsService.shared.getCommonFriends(userContacts: userContacts) else { continue }
                if friendsInCommon.count > 0 {
                    
                    interestingUser.friendsInCommon = friendsInCommon
                    interestingUser.distance = distance
                    
                    interestingUsers.append(interestingUser)
                } else {
                    print("Someone does not have friends in common")
                }
            } else {
                print(user.firstName)
            }
        }
        completion(interestingUsers)
    }
    
    
    func isCloseEnough(distance: Int) -> Bool {
        
        if distance <= distanceRequiered {
            return true
        }
        print("Someone is too far (\(distance)m)")
        return false
    }
    
}


