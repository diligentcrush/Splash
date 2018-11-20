//
//  PostTableViewCell.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/19/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var postImage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post:Post) {
        
    }
    
}

