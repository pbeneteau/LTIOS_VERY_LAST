//
//  NearbyUser.swift
//  LTios
//
//  Created by antoine beneteau on 2017-08-21.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GlobalUser {
    
    var uid: String!
    var publicName: String!
    var pushID: String!
    var firstName: String!
    var lastName: String!
    var contacts: [String:String]!
    
    var fullName: String! {
        get {
            return firstName + " " + lastName
        }
    }
    
    init(document: DocumentSnapshot) {
        
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
    }
    
    init() {
        
    }
    
}
