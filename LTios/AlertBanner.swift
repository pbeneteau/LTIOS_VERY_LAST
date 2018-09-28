//
//  AlertBanner.swift
//  LTios
//
//  Created by Paul Bénéteau on 26/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import Foundation
import NotificationBannerSwift


enum BannerType {
    case message
    case closePeople
    case unreachable
    case ghost
}

class AlertBanner {
    
    
    static func showBanner(_ type: BannerType) {
        
        let bannerView: AlertBannnerView = createBanner(type: type)
        
        let banner = NotificationBanner(customView: bannerView)
        banner.show()
    }
    
    static func showBanner(_ type: BannerType, contactName: String) {
        
        let alertBannerView = createBanner(type: type)
        alertBannerView.titleLabel.text = alertBannerView.titleLabel.text! + " \(contactName)"
        
        let banner = NotificationBanner(customView: createBanner(type: type))
        banner.show()
    }
    
    
    static func createBanner(type: BannerType) -> AlertBannnerView {

        var title = String()
        var description = String()
        
        switch type {
        case .message:
            title = "New message !"
            description = "You received a new message from /name/"
            
            break
        case .closePeople:
            title = "New people around you !"
            description = "Someone you should meet is close to you"
            break
        case .ghost:
            title = "Ghost mode activated !"
            description = "You are now invisible from other users"
            break
        default:
            title = "No network connection !"
            description = "Check your internet connection"
        }
        
        let bannerView = AlertBannnerView(type: type, title: title, description: description)
        
        return bannerView
    }
    
}


