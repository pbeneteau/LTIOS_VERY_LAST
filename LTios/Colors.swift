//
//  Colors.swift
//  LTios
//
//  Created by Paul Bénéteau on 04/10/2017.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

struct Color {
    
    struct Menu {
        struct Button {
            static let normal = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
            static let ghost = UIColor.white
            static let unreachable = UIColor.white
        }
        struct SelectionBar {
            static let normal = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
            static let ghost = UIColor.white
            static let unreachable = UIColor.white
        }
        
        struct Title {
            static let normal = UIColor.white
            static let mainView = UIColor(red:0.38, green:0.55, blue:0.96, alpha:1.0)
        }
    }
    
    struct Profile {
        static let publicName = UIColor(red:0.00, green:0.05, blue:0.25, alpha:1.0)
        static let badge = UIColor.lightGray
    }
    
    struct NearbyPlaces {
        
        struct Distance {
            struct Label {
                static let selected = UIColor(red:0.38, green:0.55, blue:0.96, alpha:1.0)
                static let normal = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
            }
            struct ProgressView {
                static let progress = UIColor(red:0.38, green:0.55, blue:0.96, alpha:1.0)
                static let background = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
            }
        }
    }
    
    static let separatorLine = UIColor.lightGray

    static let roundedBlockView = UIColor.white
    
    static let viewControllerBackground = UIColor.white
    
}


