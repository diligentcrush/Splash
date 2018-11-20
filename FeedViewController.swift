//
//  FeedViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/19/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseUI

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var homeFeed: UITableView!
    
    var posts = [
        Post(id: "1", author: "Donald Trump", text: "Bigly!"),
        Post(id: "2", author: "Kanye West", text: "Haaeeh!")
    ]
    
    // var storageHandle: StorageHandle!
    // var imageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeFeed = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        homeFeed.register(cellNib, forCellReuseIdentifier: "postCell")
        
        homeFeed.estimatedRowHeight = 400
        homeFeed.rowHeight = UITableView.automaticDimension
        
        view.addSubview(homeFeed)
       
        var layoutGuide:UILayoutGuide!
        layoutGuide = view.safeAreaLayoutGuide
        
        homeFeed.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        homeFeed.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        homeFeed.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        homeFeed.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        homeFeed.dataSource = self
        homeFeed.reloadData()
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeFeed.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
       // cell.set(post: Post)[indexPath.row]
        return cell
    }
    
    /** func loadPosts() {
        let reference = Storage().reference().child("images/0EE1CA53-5B91-4FBA-9AC2-AD6C22A2BAF4")
        let imageDownload: UIImageView = self.imageDownload
        imageDownload.sd_setImage(with: reference)
        
         imageRef = Storage.storage().reference()
        Storage.storage().reference().child("images").observe(.childAdded) {(snapshot:)
            }
        storageHandle = imageRef.child("images").observe(.childAdded, with: {(DataSnapshot) in
            let images: UIImage = (data.value as? UIImage)!
        })
    
        Storage.storage().reference().child("images").observe(.childAdded {(DataSnapshot: )})
    } **/

}


