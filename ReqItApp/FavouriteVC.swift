//
//  FavorVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/13/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class FavouriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var postKey: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        DataService.ds.REF_POSTS.queryOrderedByChild("username").queryEqualToValue(DataService.ds.uid).observeSingleEventOfType(.Value, withBlock: { postSnapshot in
            
            self.posts = []
            
            if let posts = postSnapshot.children.allObjects as? [FDataSnapshot]{
                
                for post in posts {
                    //                    print("SNAP: \(post)")
                    if let postdic = post.value as? [String:AnyObject]{
                        let post = Post(postKey: post.key, dictionary: postdic)
                        self.posts.append(post)
                    }
                }
            }
            
             self.posts.sortInPlace{ $1.createdAt < $0.createdAt}
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
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FavouriteCell") as? FavouriteCell {
            
            cell.configureCell(posts[indexPath.row])
            
            cell.accessoryType = .DetailDisclosureButton
            
            return cell
        } else {
            return FavouriteCell()
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath){
        
        let post = posts[indexPath.row]
        
        if post.pending != 0 {
        performSegueWithIdentifier(SEGUE_TO_OFFER_ACCEPT, sender: post)
        postKey = post.postKey
//        print("Hello \(postKey)")
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        /***
         * Take reffrence code from PostVC.swift in prepareForSegue
         * here check sender as? Post 
         * pass post to the OfferAcceptVC
        ***/

        
//         let viewController = OfferAcceptVC.self
 
        if segue.identifier == "segueToOfferAccept" {
            if let post = sender as? Post {
                let offerAcceptVC = segue.destinationViewController as! OfferAcceptVC
                offerAcceptVC.key = post.postKey
//                print("Success \(offerAcceptVC.key)") works
            }
        }
  

            
        
    }
    
    
}
