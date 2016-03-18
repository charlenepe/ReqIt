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

class AcceptVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var postKey: String!
    var favors = [Offer]()
    

    
    @IBOutlet weak var bidTableView: UITableView!
    
    

    @IBOutlet weak var backBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        bidTableView.delegate = self
        bidTableView.dataSource = self
        
        print(postKey)
        
        let bidCell = Firebase(url:"https://reqit.firebaseio.com/users/\(uid)/posts/\(postKey)/offers")
  
        
        
        bidCell.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.favors = []
       
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                
                
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postdic = snap.value as? Dictionary <String, AnyObject>{
                        let key = snap.key
                        let offer = Offer(bidKey: key, dictionary: postdic)
                        
                        self.favors.append(offer)

                        }
                        
                    }
                }
            //
            self.bidTableView.reloadData()
        })

        }
        
    


    
    
    @IBAction func backActn(sender: AnyObject) {
       
    }
//    @IBAction func backPressed(sender: AnyObject) {
//        
//        performSegueWithIdentifier("seguetoFavorVC", sender: self)
//
//    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favors.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let favor = favors[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("acceptCell") as? AcceptCell {
            var img: UIImage?
            
//            
//            if let url = post.imgURL {
//                img = FeedVC.imageCache.objectForKey(url) as? UIImage
//            }
//            //
            
            
            cell.configureCell(favor)
            
            return cell
        } else {
            return AcceptCell()
        }

    }
    

    
    

    /*  ``
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//For ref...here's the code for FavorVC! :P

//var postKey: String!
//var postTitle: String!
//
//
//@IBOutlet weak var feed: UITabBarItem!
//@IBOutlet weak var tableView: UITableView!
//
//var posts = [Post]()
//var unhiddenposts = [Post]()
//let uid = reff.authData.uid
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    tableView.delegate = self
//    tableView.dataSource = self
//    
//    
//    //
//    //        let ref = Firebase(url:"http://reqit.firebase.com/users/\(uid)/posts")
//    //        // Attach a closure to read the data at our posts reference
//    //        ref.observeEventType(.Value, withBlock: { snapshot in
//    //            print(snapshot.value)
//    //            }, withCancelBlock: { error in
//    //                print(error.description)
//    
//    
//    DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
//        print(snapshot.value)
//        self.posts = []
//        self.unhiddenposts = []
//        
//        if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
//            
//            
//            for snap in snapshots {
//                print("SNAP: \(snap)")
//                if let postdic = snap.value as? Dictionary <String, AnyObject>{
//                    let key = snap.key
//                    let post = Post(postKey: key, dictionary: postdic)
//                    
//                    self.posts.append(post)
//                    
//                    if post.username == self.uid {
//                        self.unhiddenposts.append(post)
//                    }
//                    
//                }
//            }
//        }
//        //
//        self.tableView.reloadData()
//    })
//    
//    
//    
//    // Do any additional setup after loading the view.
//}
//
//func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    
//    
//    let post = unhiddenposts[indexPath.row]
//    
//    
//    if let cell = tableView.dequeueReusableCellWithIdentifier("favorCell") as? FavorCell {
//        
//        //if let data = NSData(contentsofURL: url){
//        //let img= UIImage(data: data)
//        //}
//        cell.accessoryType = .DetailDisclosureButton
//        
//        cell.configureCell(post)
//        //              cell.hidePost(post)
//        return cell
//    } else {
//        return FavorCell()
//    }
//}
//
//func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath){
//    
//    let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! FavorCell
//    
//    
//    performSegueWithIdentifier("seguetoAccept", sender: self)
//    
//    
//}
//
//
//override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    
//    let viewControllerAccept = segue.destinationViewController as! AcceptVC
//    viewControllerAccept.postKey = postKey
//    
//    //passing the postKey to AcceptVC's postKey :P
//    
//}
//
//
//
//
//func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return 1
//}
//
//func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return unhiddenposts.count
//}
//
