//
//  Device.swift
//  LTios
//
//  Created by Paul Bénéteau on 20/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import Foundation
import CoreBluetooth

struct Device {
    
    var peripheral : CBPeripheral
    var uid : String
    var messages = Array<String>()
    
    init(peripheral: CBPeripheral, uid: String) {
        self.peripheral = peripheral
        self.uid = uid
    }
}
