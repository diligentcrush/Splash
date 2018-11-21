//
//  UserProfile.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/20/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import Foundation
import Firebase

class UserProfile {
    var uid:String
    var username:String
    var profileUrl:URL
    
    init(uid:String, username:String, profileUrl:URL) {
        self.uid = uid
        self.username = username
        self.profileUrl = profileUrl
    }
}
