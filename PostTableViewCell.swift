//
//  PostTableViewCell.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/19/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    weak var post:Post?
    
    func set(post:Post) {
        self.post = post
        
        self.postImage.image = nil
        ImageService.getImage(withURL: post.author.profileUrl) { image, url in
            guard let _post = self.post else { return }
            if _post.author.profileUrl.absoluteString == url.absoluteString {
                self.profileImage.image = image
            } else {
                print("Not the right image")
            }
            
        }
        
        usernameLabel.text = post.author.username
        captionLabel.text = post.caption
        // timestampLabel.text = post.createdAt.calendarTime
    }
}

