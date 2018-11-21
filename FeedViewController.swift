//
//  FeedViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/19/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var homeFeed: UITableView!
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    var posts = [Post]()
    var fetchingMore = false
    var endReached = false
    let leadingScreensForBatching:CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeFeed = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        homeFeed.register(cellNib, forCellReuseIdentifier: "postCell")
        homeFeed.register(LoadingCell.self, forCellReuseIdentifier: "loadingCell")
        
        view.addSubview(homeFeed)
       
        var layoutGuide:UILayoutGuide!
        layoutGuide = view.safeAreaLayoutGuide
        
        homeFeed.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        homeFeed.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        homeFeed.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        homeFeed.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        homeFeed.delegate = self
        homeFeed.dataSource = self
        homeFeed.reloadData()
        
        // observePosts()
        beginBatchFetch()

    }
    
    func fetchPost (completion: @escaping (_ posts: [Post]) -> ()) {
        let postsRef = Database.database().reference().child("posts")
        var queryRef: DatabaseQuery
        let lastPost = posts.last
        if lastPost != nil {
            let lastTimestamp = lastPost!.createdAt.timeIntervalSince1970 * 1000
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp).queryLimited(toLast: 20)
        } else {
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 20)
    }
        
        queryRef.observeSingleEvent(of: .value, with: {snapshot in
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    let author = dict["author"] as? [String: Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let profileUrl = author["profileUrl"] as? String,
                    let urlOfProfile = URL(string:profileUrl),
                    let caption = dict["caption"] as? String,
                    let picUrl = dict["picUrl"] as? String,
                    let urlOfPic = URL(string: picUrl),
                    let timestamp = dict["timestamp"] as? Double {
                    
                    if childSnapshot.key != lastPost?.id {
                        let userProfile = UserProfile(uid: uid, username: username, profileUrl: urlOfProfile)
                        let post = Post(id: childSnapshot.key, author: userProfile, caption: caption, picUrl: urlOfPic, timestamp: timestamp)
                        tempPosts.insert(post, at: 0)
                    }
                    
                }
                    
                }
            
            return completion(tempPosts)
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return posts.count
        case 1:
            return fetchingMore ? 1 : 0
        default:
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = homeFeed.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
            cell.set(post: posts[indexPath.row])
            return cell
        } else {
            let cell = homeFeed.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        self.homeFeed.reloadSections(IndexSet(integer: 1), with: .fade)
        
        fetchPost { newPosts in
            self.posts.append(contentsOf: newPosts)
            self.fetchingMore = false
            self.endReached = newPosts.count == 0
            UIView.performWithoutAnimation {
                self.homeFeed.reloadData()
            }
        }
    }
    

}


