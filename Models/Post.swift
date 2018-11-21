//
//  Post.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/19/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import Foundation

class Post {
    var id:String
    var author:UserProfile
    var caption:String
    var picUrl: URL
    var createdAt: Date
    
    init(id:String, author:UserProfile, caption:String, picUrl: URL, timestamp: Double) {
        self.id = id
        self.author = author
        self.caption = caption
        self.picUrl = picUrl
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }
}
