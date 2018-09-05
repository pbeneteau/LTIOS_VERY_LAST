//
//  DatabaseService.swift
//  LT_Contacts_Manager
//
//  Created by Paul Bénéteau on 30/07/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import CoreLocation
import FirebaseFirestore
import FirebaseDatabase

// MARK: Firebase database related queries
class DatabaseService {
    
    public static var shared = DatabaseService()
    private var nearbyUserListener: ListenerRegistration!
    
    private let db: Firestore!
    private let settings: FirestoreSettings!
    
    init() {
        
        db = Firestore.firestore()
        
        settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true        
        db.settings = settings
    }
    
    deinit {
        stopListeningForNearbyUsers()
    }
}

extension DatabaseService {
    
    func makeUserOnline() {
        
        let userStatusDatabaseRef = Database.database().reference().child("/status/" + mainUserInstance.uid)
        let firestore = Firestore.firestore().collection("users").document(mainUserInstance.uid)
        
        // Set the specific user's online status to true
        firestore.setData(["online": true], merge: true)
        userStatusDatabaseRef.setValue(true)
    }
    
    func setOnDisconnectHandler() {
        
        let presenceRef = Database.database().reference(withPath: "status/\(String(describing: mainUserInstance.uid!))");
        // Write a string when this client loses connection
        presenceRef.onDisconnectSetValue(false)
    }
    
    // Listening for users in the same state
    func listenForNearbyUsers() {
        
        if nearbyUserListener != nil {
            return
        }
        
        print("Start listening for nearby users ...")
        
        nearbyUserListener = db.collection("countries")
            .document((mainUserInstance.address?.ISO)!)
            .collection("states")
            .document((mainUserInstance.address?.state)!)
            .collection("users").addSnapshotListener { documentSnapshot, error in
                
                guard let usersCollection = documentSnapshot?.documents else {
                    print("[Error] listening for nearby users: \(error!.localizedDescription)")
                    return
                }
                
                if usersCollection.count > 0 {
                    print("\(usersCollection.count - 1) nearby users found")
                    self.fetchUsersProfile(usersCollection: usersCollection) { users in
                        guard let nearbyUsers = users else { print("[Error] unwrapping nearby users profile"); return }
                        self.notifyDidUpdateNearbyUsers(nearbyUsers: nearbyUsers) // Notify viewControllers
                    }
                } else {
                    print("No nearby users.")
                }
        }
    }
    
    func stopListeningForNearbyUsers() {
        nearbyUserListener.remove()
    }
    
    private func fetchUsersProfile(usersCollection: [QueryDocumentSnapshot], completion: @escaping([InterestingUser]?) -> Void) {
        
        if usersCollection.count != 0 {
            
            print("Fetching nearby users profile ...")
            
            var nearbyUsers = [InterestingUser]()
            let dispatchGroup = DispatchGroup()
            
            for doc in usersCollection {
                if doc.documentID != mainUserInstance.uid {
                    dispatchGroup.enter()
                    DatabaseService.shared.getUserInformation(uid: doc.documentID) { document in
                        guard let document = document else { dispatchGroup.leave(); return }
                        
                        let newUser = InterestingUser(document: document)
                        
                        StorageService.shared.downloadUserPicture(uid: newUser.uid) { photo in
                            guard let photo = photo else { dispatchGroup.leave(); return }
                            newUser.photo = photo
                            nearbyUsers.append(newUser)
                            dispatchGroup.leave()
                        }
                    }
                }
            }
            dispatchGroup.notify(queue: .main, execute: {
                completion(nearbyUsers)
            })
        } else {
            completion(nil)
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
                print("[Error] updating local location: \(err.localizedDescription)")
            }
        }
        
        self.db.document("users/\(mainUserInstance.uid!)").updateData([
            "last_location": GeoPoint(latitude: (mainUserInstance.location?.latitude)!, longitude: (mainUserInstance.location?.longitude)!)
        ]) { err in
            if let err = err {
                print("[Error] updating last location: \(err.localizedDescription)")
            }
        }
    }
    
    // Get any user profile from his user id
    func getUserInformation(uid: String, completion: @escaping (DocumentSnapshot?) -> Void) {
        
        db.collection("users").document(uid).getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("[Error] fetching document: \(error!)")
                completion(nil)
                return
            }
            if (document.exists) {
                completion(document)
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
                print("[Error] uploading contacts: \(err.localizedDescription)")
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
                "firstName": firstname,
                "lastName": lastname
            ],
            "publicName": "Drope",
            "pushID": uid
        ]) { err in
            if let err = err {
                print("Error creating user: \(err.localizedDescription).")
            } else {
                print("New user created successfuly.")
            }
        }
    }
    
    func onDisconnectHandler() {
        
    }
    
}

// MARK: Notification Observers
extension DatabaseService {
    
    func notifyDidUpdateNearbyUsers(nearbyUsers: [InterestingUser]) {
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateCloseUsers"), object: nil, userInfo: ["closeUsers" : nearbyUsers])
        print("Did update nearby users.")
    }
}
