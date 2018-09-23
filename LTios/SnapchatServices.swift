//
//  BitmojiServices.swift
//  LTios
//
//  Created by Paul Bénéteau on 14/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import SCSDKBitmojiKit
import SCSDKLoginKit

class SnapchatServices {
    
    
    public static var shared = SnapchatServices()
    
    func fetchAvatarURL(completion: @escaping(String?) -> Void) {
        
        SCSDKBitmojiClient.fetchAvatarURL { (avatarURL: String?, error: Error?) in
            
            if let error = error {
                print("[Error] fetching Bitmoji: " + error.localizedDescription)
                completion(nil)
            } else {
                guard let URL = avatarURL else {
                    completion(nil)
                    return
                }
                completion(URL)
            }
        }
    }
    
    private func fetchSnapUserData(completion: @escaping(Data?) -> Void) {
        
        let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
        
        SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: nil,
                success: { userInfo in
                    if let userInfo = userInfo,
                        let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted) {
                        
                        print(data)
                        completion(data)
                    } else {
                        completion(nil)
                    }
            }) { (error, isUserLoggedOut) in
                print(error?.localizedDescription ?? "")
                completion(nil)
        }
    }
    
    
}

