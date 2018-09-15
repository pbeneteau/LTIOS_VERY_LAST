//
//  Settings.swift
//  LTios
//
//  Created by Paul Bénéteau on 15/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//


struct Settings {
    
    var sectionName: String
    var name: String
    
    var type: SettingsType
    
    init(sectionName: String, name: String, type: SettingsType) {
        self.sectionName = sectionName
        self.name = name
        self.type = type
    }

}

enum SettingsType {
    case onOff
    case Segue
}
