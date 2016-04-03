//
//  AcceptVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/16/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class OfferAcceptVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    var favors = [Offer]()
    var key: String! //this is the postKey
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        

        /***
         * Here you need to use queryOrderedByChild method and load all offers
         * which is not accepted yet and postKey
         * Reference code take from FavouriteVC.swift in viewWillApear func
         ***/
    

        DataService.ds.REF_OFFERS.queryOrderedByChild("postKey").queryEqualToValue(key).observeEventType(.Value, withBlock: { favorSnapshot in
            
            self.favors = []
            
            if let favors = favorSnapshot.children.allObjects as? [FDataSnapshot]{
                
                
                for favor in favors {
                    print("SNAP: \(favor)")
                    if let fdic = favor.value as? [String:AnyObject]{
                        let offer = Offer(offerKey: favor.key , dictionary: fdic)
                        self.favors.append(offer)
                     
                    }
                }
            }
             self.favors.sortInPlace{ $1.createdAt < $0.createdAt}
            self.tableView.reloadData()
        })
    }



    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favors.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 166
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        

        
        if let cell = tableView.dequeueReusableCellWithIdentifier("OfferAcceptCell") as? OfferAcceptCell {
            var img: UIImage?
            
            let favor = favors[indexPath.row]

            
            cell.configureCell(favor, img: img)
            
            
            return cell
        } else {
            return OfferAcceptCell()
        }
        
    }
    
    
    
    

    @IBAction func funcAcceptButton(sender: AnyObject) {
    
        
        let alert = UIAlertController(title: "Accept offer", message: "Accepting this offer will remove this post from the ReqFeed", preferredStyle:UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {
        (alert: UIAlertAction!) -> Void in
            
    
            
            
            
            let ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabVC") as! UITabBarController
        
            
            
            self.presentViewController(ViewController, animated:true, completion:nil)
        
            
            //you delete the post from the post node
            
            DataService.ds.REF_POSTS.childByAppendingPath(self.key).removeValue()
            //you delete favors from the favor node of they have a postkey eq to the postkey
            
            //
            //        REF_OFFERS.queryOrderedByChild("postKey").queryEqualToValue(key).
            
            DataService.ds.REF_OFFERS.queryOrderedByChild("postKey").queryEqualToValue(self.key).observeSingleEventOfType(.Value, withBlock: { offerSnapshot in
                
                if let offerKey = offerSnapshot.value as? String {
                    
                    DataService.ds.REF_OFFERS.childByAppendingPath(offerKey).removeValue()
                    DataService.ds.REF_USERS.childByAppendingPath("offers").childByAppendingPath(offerKey).removeValue()
//                    
//                      self.tableView.reloadData()
                    
                   
//      
//                    let vc :PostVC = storyboard.instantiateViewControllerWithIdentifier("FeedVC") as! PostVC
//                    
//                    let navigationController = UINavigationController(rootViewController: )
//                    
//                    self.presentViewController(navigationController, animated: true, completion: nil)
//                    
//                    
//                    let ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("FeedVC") as! PostVC
//                    
//                    self.presentViewController(ViewController, animated:true, completion:nil)
                    
                    //                DataService.ds.REF_USERS.queryOrderedByChild()
                    //
                    //                    childByAppendingPath(offerKey).removValue()
                    
                }
            })
            self.tableView.reloadData()
            
            //remove offers from the users involved
        
        })
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)

        
        
        
     

        
        
        
        
        //        userOfferREF.observeSingleEventOfType(.Value, withBlock: { offerSnapshot in
        //
        //            //Load Offer Data
        //            if let offerKey = offerSnapshot.value as? String {
        //                DataService.ds.REF_OFFERS.childByAppendingPath(offerKey).observeSingleEventOfType(.Value, withBlock: { offerDataSnapshot in
        //
        //                    if let offerDic = offerDataSnapshot.value as? [String: AnyObject] {
        //                        let offer = Offer(offerKey: offerKey, dictionary: offerDic)
        //
        //                        //Update Bid Count
        //                        post.removeBid(offer)
        //                        //Remove User Offer Node
        //                        userOfferREF.removeValue()
        //                        //Remove Offer Node itself
        //
        //
        //                        DataService.ds.REF_OFFERS.childByAppendingPath(offerKey).removeValue()
        //                        //reload tableview
        //
        
        
        
        
        
        
        //        DataService.ds.REF_OFFERS.observeEventType(.Value, withBlock: { postSnapshot in
        //            self.posts = []
        //
        //            if let postData = postSnapshot.children.allObjects as? [FDataSnapshot]{
        //
        //                for post in postData {
        //                    //print("SNAP: \(post)")
        //                    if let postdic = post.value as? [String:AnyObject]{
        //                        let post = Post(postKey: post.key, dictionary: postdic)
        //                        self.posts.append(post)
        //                    }
        //                }
        //            }
        
        
        
        
        //
        //        if let btn = sender as? UIButton {
        //
        //            let post = posts[btn.tag]
        //
        //            let alert = UIAlertController(title: "Delete \"\(post.title)\" ", message: "Deleting \"\(post.title)\" will also delete all of its data", preferredStyle:UIAlertControllerStyle.Alert)
        //
        //            let okAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {
        //                (alert: UIAlertAction!) -> Void in
        //
        //                DataService.ds.REF_POSTS.childByAppendingPath(post.postKey).removeValue()
        //
        //                self.tableView.reloadData()
        //            })
        //
        //            alert.addAction(okAction)
        //
        //            presentViewController(alert, animated: true, completion: nil)
        //
        //        }
        //    }
        
        
        
        
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
}







///if you reject--- it will just be removed




//import UIKit
//import Firebase
//import FBSDKCoreKit
//import FBSDKLoginKit
//
//class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
//    
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var posts = [Post]()
//    var favor = Offer!()
//    var post: Post?
//    
//    
//    
//    static var imageCache = NSCache()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        loadPost()
//    }
//    
//    func loadPost() {
//        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { postSnapshot in
//            self.posts = []
//            
//            if let postData = postSnapshot.children.allObjects as? [FDataSnapshot]{
//                
//                for post in postData {
//                    //print("SNAP: \(post)")
//                    if let postdic = post.value as? [String:AnyObject]{
//                        let post = Post(postKey: post.key, dictionary: postdic)
//                        self.posts.append(post)
//                    }
//                }
//            }
//            
//            if self.posts.count > 0 {
//                self.posts.sortInPlace{ $0.createdAt > $1.createdAt}
//                self.tableView.reloadData()
//            }
//            
//        })
//    }
//    
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
//            var imgCached: UIImage?
//            
//            let post = posts[indexPath.row]
//            
//            if let url = post.imgURL {
//                imgCached = PostVC.imageCache.objectForKey(url) as? UIImage
//            }
//            
//            
//            cell.configureCell(post, img:imgCached)
//            
//            cell.btnDelete.tag = indexPath.row
//            cell.btnUpdate.tag = indexPath.row
//            cell.btnBid.tag = indexPath.row
//            cell.btnUnBid.tag = indexPath.row
//            
//            return cell
//        } else {
//            return PostCell()
//        }
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        
//        if  segue.identifier == SEGUE_TO_POST_UPDATE {
//            if let postUpdateVC = segue.destinationViewController as? PostUpdateVC, let btn = sender as? UIButton {
//                
//                postUpdateVC.post = self.posts[btn.tag]
//            }
//        } else if segue.identifier == SEGUE_TO_OFFER_ADD {
//            
//            if let offerAddVC = segue.destinationViewController as? OfferAddVC, let btn = sender as? UIButton {
//                offerAddVC.post = self.posts[btn.tag]
//            }
//            
//        }
//        
//    }
//    
//    
//    @IBAction func unbidBtn(sender: UIButton) {
//        
//        //Some time you can cast "sender", directly in parameter coz you know it will always be a button or something
//        
//        let post = posts[sender.tag]
//        
//        
//        //        let alert = UIAlertController(title: "Retract bid", message: "Are you sure you want to retract your offer?", preferredStyle:UIAlertControllerStyle.Alert)
//        //
//        //
//        //
//        //        let okAction = UIAlertAction(title: "Remove bid", style: UIAlertActionStyle.Default, handler: {
//        //            (alert: UIAlertAction!) -> Void in
//        
//        
//        
//        
//        /** UnBid Steps
//        1. Load Offer Data and Pass to RemoveBid in PostModal
//        2. Update Bid Count with func post.removeBid(offerData)
//        3. Remove Offer From User Node
//        4. Remove Offer Node itself
//        5. Reload tableview
//        **/
//        
//        let userOfferREF = DataService.ds.REF_CURRENT_USER.childByAppendingPath("offers").childByAppendingPath(post.postKey)
//        
//        userOfferREF.observeSingleEventOfType(.Value, withBlock: { offerSnapshot in
//            
//            //Load Offer Data
//            if let offerKey = offerSnapshot.value as? String {
//                DataService.ds.REF_OFFERS.childByAppendingPath(offerKey).observeSingleEventOfType(.Value, withBlock: { offerDataSnapshot in
//                    
//                    if let offerDic = offerDataSnapshot.value as? [String: AnyObject] {
//                        let offer = Offer(offerKey: offerKey, dictionary: offerDic)
//                        
//                        //Update Bid Count
//                        post.removeBid(offer)
//                        //Remove User Offer Node
//                        userOfferREF.removeValue()
//                        //Remove Offer Node itself
//                        
//                        
//                        DataService.ds.REF_OFFERS.childByAppendingPath(offerKey).removeValue()
//                        //reload tableview
//                        self.tableView.reloadData()
//                    }
//                })
//            }
//        })
//    }
//    
//    @IBAction func btnDeleteClicked(sender: AnyObject) {
//        if let btn = sender as? UIButton {
//            
//            let post = posts[btn.tag]
//            
//            let alert = UIAlertController(title: "Delete \"\(post.title)\" ", message: "Deleting \"\(post.title)\" will also delete all of its data", preferredStyle:UIAlertControllerStyle.Alert)
//            
//            let okAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {
//                (alert: UIAlertAction!) -> Void in
//                
//                DataService.ds.REF_POSTS.childByAppendingPath(post.postKey).removeValue()
//
//                self.tableView.reloadData()
//            })
//            
//            alert.addAction(okAction)
//            
//            presentViewController(alert, animated: true, completion: nil)
//            
//        }
//    }
//    
//    
//}

