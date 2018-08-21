//
//  Fonts.swift
//  LTios
//
//  Created by Paul Bénéteau on 04/10/2017.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit


struct LTFont {
    
    struct Menu {
        static let title = UIFont(name: "Roboto-Medium", size: 23)
    }
    
    struct NearbyPlaces {
        
        struct TableView {
            
            static let headerTitle = UIFont(name: "Roboto-Regular", size: 26)
            
            struct Cell {
                static let type = UIFont(name: "Roboto-Medium", size: 15)
                static let name = UIFont(name: "Roboto-Black", size: 17)
                static let distance = UIFont(name: "Roboto-Regular", size: 16)
                static let people = UIFont(name: "Roboto-Bold", size: 20)
            }
        }
    }
    
    
    struct regular {
        
        static let bigTitle = UIFont(name: "Helvetica Neue", size: 35)
        static let title = UIFont(name: "Helvetica Neue", size: 30)
        static let smallTitle = UIFont(name: "Helvetica Neue", size: 25)
        static let subtitle = UIFont(name: "Helvetica Neue", size: 20)
        static let bigText = UIFont(name: "Helvetica Neue", size: 15)
        static let text = UIFont(name: "Helvetica Neue", size: 13)
    }
}


extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}
