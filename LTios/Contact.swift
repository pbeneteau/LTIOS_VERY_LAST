//
//  Contact.swift
//  LTios
//
//  Created by antoine beneteau on 2017-10-30.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

struct Contact: Equatable {
    
    // Primary datas
    var firstName: String
    var lastName: String
    var phoneNumber: String?
    var profilePicture: UIImage?
    var country: String?
    
    init(firstName: String, lastName: String, country: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.country = country
    }
    
    init(firstName: String, lastName: String, phoneNumber: String, profilePicture: UIImage, country: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.country = country
    }
}

func ==(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.phoneNumber == rhs.phoneNumber
}
