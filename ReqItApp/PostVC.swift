//
//  FeedVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    static var imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPost()
    }
    
    func loadPost() {
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { postSnapshot in
            self.posts = []
            
            if let postData = postSnapshot.children.allObjects as? [FDataSnapshot]{
                
                for post in postData {
                    //print("SNAP: \(post)")
                    if let postdic = post.value as? [String:AnyObject]{
                        let post = Post(postKey: post.key, dictionary: postdic)
                        self.posts.append(post)
                    }
                }
            }
            self.posts.sortInPlace{ $0.createdAt > $1.createdAt}
            self.tableView.reloadData()
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            var imgCached: UIImage?
            
            let post = posts[indexPath.row]
            
            if let url = post.imgURL {
                imgCached = PostVC.imageCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(post, img:imgCached)
            
            cell.btnDelete.tag = indexPath.row
            cell.btnUpdate.tag = indexPath.row
            cell.btnBid.tag = indexPath.row
            cell.btnUnBid.tag = indexPath.row
            
            return cell
        } else {
            return PostCell()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if  segue.identifier == SEGUE_TO_POST_UPDATE {
            if let postUpdateVC = segue.destinationViewController as? PostUpdateVC, let btn = sender as? UIButton {
                
                postUpdateVC.post = self.posts[btn.tag]
            }
        } else if segue.identifier == SEGUE_TO_OFFER_ADD {
            
            if let offerAddVC = segue.destinationViewController as? OfferAddVC, let btn = sender as? UIButton {
                offerAddVC.post = self.posts[btn.tag]
            }
            
        }
        
    }
    
    @IBAction func btnDeleteClicked(sender: AnyObject) {
        if let btn = sender as? UIButton {
            
            let post = posts[btn.tag]
            
            let alert = UIAlertController(title: "Delete \"\(post.title)\" ", message: "Deleting \"\(post.title)\" will also delete all of its data", preferredStyle:UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                DataService.ds.REF_POSTS.childByAppendingPath(post.postKey).removeValue()
                
                self.tableView.reloadData()
            })
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    
}