//
//  DatabaseService.swift
//  LT_Contacts_Manager
//
//  Created by Paul Bénéteau on 30/07/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import CoreLocation
import FirebaseFirestore

// MARK: Firebase database related queries
class DatabaseService {
    
    public static var shared = DatabaseService()
    
    let db: Firestore!
    let settings: FirestoreSettings!
    
    init() {
        
        db = Firestore.firestore()
        
        settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
}

extension DatabaseService {
    
    // Listening for users in the same state
    func listenForNearbyUsers() {
        db.collection("countries").document((mainUserInstance.address?.ISO)!).collection("states").document((mainUserInstance.address?.state)!).collection("users").addSnapshotListener { documentSnapshot, error in
            guard let usersCollection = documentSnapshot?.documents else {
                print("Error fetching document: \(error!)")
                return
            }
            var nearbyUsers = [InterestingUser]()
            
            if usersCollection.count > 0 {
                self.fetchUsersProfile(usersCollection: usersCollection) { users in
                    guard let users = users else { return }
                    
                    nearbyUsers = users
                    self.notifyDidUpdateNearbyUsers(nearbyUsers: nearbyUsers) // Notify viewcontrollers
                }
            }
        }
    }
    
    private func fetchUsersProfile(usersCollection: [QueryDocumentSnapshot], completion: @escaping([InterestingUser]?) -> Void) {
        
        var nearbyUsers = [InterestingUser]()
        
        let asyncOperation = AsyncOperation(numberOfSimultaneousActions: 1, dispatchQueueLabel: "fetchingNearbyUsersInfo")
        asyncOperation.whenCompleteAll = {
            completion(nearbyUsers)
        }
        for doc in usersCollection {
            
            asyncOperation.run { completeClosure in
                if doc.documentID != mainUserInstance.uid {
                    
                    DatabaseService.shared.getUserInformation(uid: doc.documentID) { document in
                        guard let document = document else { completion(nil); return }
                        
                        let newUser = InterestingUser(document: document)
                        
                        nearbyUsers.append(newUser)
                        
                        completeClosure()
                    }
                } else {
                    completeClosure()
                }
            }
        }
    }
    
    // Update user location in database
    func updateUserDatabaseLocation() {
        
        let location = mainUserInstance.location
        let iso = mainUserInstance.address?.ISO
        let state = mainUserInstance.address?.state
        
        self.db.document("countries/\(String(describing: iso!))/states/\(String(describing: state!))/users/\(String(describing: mainUserInstance.uid!))").setData([
            "location": [
                "coordinate": location
            ]
        ]) { err in
            if let err = err {
                print("Error updating local location: \(err.localizedDescription)")
            } else {
                print("Local location updated successfuly.")
            }
        }
        
        self.db.document("users/\(mainUserInstance.uid!)").updateData([
            "last_location": GeoPoint(latitude: (mainUserInstance.location?.latitude)!, longitude: (mainUserInstance.location?.longitude)!)
        ]) { err in
            if let err = err {
                print("Error updating last location: \(err.localizedDescription)")
            } else {
                print("Last location updated successfuly.")
            }
        }
    }
    
    // Get any user profile from his user id
    func getUserInformation(uid: String, completion: @escaping (DocumentSnapshot?) -> Void) {
        
        db.collection("users").document(uid).getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                completion(nil)
                return
            }
            if (document.exists) {
                completion(document)
                self.notifyDidUpdateUserProfile()
            } else {
                completion(nil)
            }
        }
    }
    
    func uploadUserContactsToDatabase(contacts: [String:String]) {
        
        self.db.document("users/\(String(describing: mainUserInstance.uid!))").updateData([
            "contacts" : contacts
        ]) { err in
            if let err = err {
                print("Error uploading contacts: \(err.localizedDescription)")
            } else {
                print("Contacts uploaded successfuly.")
            }
        }
    }
    
    // Creating a new user : add his information in database
    func createNewUserInDatabase(uid: String, firstname: String, lastname: String) {
        
        // Add a new document in collection "cities"
        self.db.document("users/\(uid)").setData([
            "name": [
                "firstname": firstname,
                "lastname": lastname
            ]
        ]) { err in
            if let err = err {
                print("Error creating user: \(err.localizedDescription).")
            } else {
                print("New user created successfuly.")
            }
        }
    }

}

// MARK: Notification Observers
extension DatabaseService {
    
    func notifyDidUpdateNearbyUsers(nearbyUsers: [InterestingUser]) {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateNearbyUsers"), object: nil, userInfo: ["nearbyUsers" : nearbyUsers])
        print("Did update nearby users.")
    }
    
    func notifyDidUpdateUserProfile() {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateUserProfile"), object: nil, userInfo: nil)
        print("Did update user profile.")
    }
    
}
