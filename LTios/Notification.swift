//
//  Notification.swift
//  LTios
//
//  Created by Paul Bénéteau on 27/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import Foundation


enum UserNotificationType {
    case friendRequest
    case message
    // ...
}


class UserNotification {
    
    var type: UserNotificationType!
    
    var title: String!
    var subtitle: String!
    
    var user: GlobalUser!
    
    
    init(type: UserNotificationType, user: GlobalUser) {
        self.type = type
        self.user = user
        
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
}

