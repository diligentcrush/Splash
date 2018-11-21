//
//  UserService.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/20/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile: UserProfile?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: {snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let profileUrl = dict["profileUrl"] as? String,
                let urlOfProfile = URL(string: profileUrl) {
                
                userProfile = UserProfile(uid: snapshot.key, username: username, profileUrl: urlOfProfile)
            }
            
            completion(userProfile)
        })
    }
}


