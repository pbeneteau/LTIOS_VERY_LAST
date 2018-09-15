//
//  BitmojiServices.swift
//  LTios
//
//  Created by Paul Bénéteau on 14/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import SCSDKBitmojiKit
import SCSDKLoginKit

class BitmojiServices {
    
    
    public static var shared = BitmojiServices()
    
    
    func fetchAvatarURL(completion: @escaping(String?) -> Void) {
        
        SCSDKBitmojiClient.fetchAvatarURL { (avatarURL: String?, error: Error?) in
            
            if let error = error {
                print("[Error] " + error.localizedDescription)
                completion(nil)
                return
            } else {
                guard let URL = avatarURL else {
                    completion(nil)
                    return
                }
                completion(URL)
                return
            }
        }
    }
    
    private func fetchSnapUserInfo() {
        
    
    }
    
    
}

