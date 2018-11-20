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
    var author:String
    var caption:String
    
    init(id:String, author:String, text:String) {
        self.id = id
        self.author = author
        self.caption = text
    }
    
}
