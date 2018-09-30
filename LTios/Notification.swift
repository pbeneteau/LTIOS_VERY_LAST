//
//  Notification.swift
//  LTios
//
//  Created by Paul Bénéteau on 27/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import Foundation


enum UserNotificationType: String {
    case friendRequest = "friendRequest"
    case message = "message"
    // ...
}


class UserNotification {
    
    var type: UserNotificationType!
    
    var title: String!
    var subtitle: String!
    var date: Date {
        didSet {
            dateToString()
        }
    }
    var dateString: String!
    
    var user: GlobalUser!
    
    
    init(type: UserNotificationType, user: GlobalUser, date: Date) {
        self.type = type
        self.user = user
        self.date = date
        
        commonInit()
    }
    
    func commonInit() {
        
        if let type = self.type {
            
            switch type {
            case .message:
                subtitle = "New message"
            case .friendRequest:
                subtitle = "Friend request"
            }
        }
        
        title = user.fullName
    }
    
    func dateToString() {
        self.dateString = "Yesterday"
    }
}

