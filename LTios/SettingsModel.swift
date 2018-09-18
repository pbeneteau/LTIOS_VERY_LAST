//
//  SettingsModel.swift
//  LTios
//
//  Created by Paul Bénéteau on 17/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit


class SettingsModel: NSObject {
    
    let sectionsNames = ["Notifications", "Privacy", "Social", "Appearance"]
    
    let names = [
        ["Push Notifications", "Chat Notifications", "Friends Notifications"],
        ["Ghost Mode", "Background Location"],
        ["Snapchat Account"]]
    
    let descriptions = [
        ["Receive weekly push notifications", "Receive chat notifications", "Receive friends notifications"],
        ["Be hidden from other users", "Disable location when Little World is close"],
        ["Unlock cool Snapchat stuff"]]
    
    let types: [[SettingsCellType]] = [
        [.onOff, .onOff, .onOff],
        [.onOff, .onOff],
        [.segue]]
    
    var states = [Int : [Int : Bool]]()
    
    init(userSettings: [Int : [Int: Bool]]) {
        super.init()
        
        self.states = userSettings
    }
    
    override init() {
    }
    
    func getSectionName(section: Int) -> String {
        return sectionsNames[section]
    }
    
    func getName(section: Int, row: Int) -> String {
        return names[section][row]
    }
    
    func getDescription(section: Int, row: Int) -> String {
        return descriptions[section][row]
    }
    
    func getState(section: Int, row: Int) -> Bool {
        return states[section]?[row] ?? false
    }
    
    func getType(section: Int, row: Int) -> SettingsCellType {
        return types[section][row]
    }
    
    func getTotalSections() -> Int {
        return names.count
    }
    
    func getTotalRows(section: Int) -> Int {
        return names[section].count
    }
}
