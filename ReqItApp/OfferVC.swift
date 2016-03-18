//
//  OfferVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/13/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class OfferVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    static var imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                
                
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postdic = snap.value as? Dictionary <String, AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postdic)
                        self.posts.append(post)
                        
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        //listen for whatever change is made in the data
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            var img: UIImage?
            
            
            if let url = post.imgURL {
                img = PostVC.imageCache.objectForKey(url) as? UIImage
            }
            //
//            cell.accessoryType = .DetailDisclosureButton
            
            
            //
            //           cell.updateBtn.tag = indexPath.row
            //           cell.updateBtn.addTarget(self, action: "buttonselect:", forControlEvents: UIControlEvents.TouchUpInside)
            //            cell.bidBtn.tag = indexPath.row
            //            cell.bidBtn.addTarget(self, action: "buttonselect:", forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.configureCell(post,img:img)
//            cell.showBtns(post)
            
            return cell
        } else {
            return PostCell()
        }
        
        
    }
    
    
    
//    
//    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath){
//        
//        
//        // Get Cell Label
//        //        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! PostCell
//        
//        /// Right now, you have to click the whole cell to be able to pass the data to UpdateVC :| SHOULD ONLY BE TRIGGERED WHEN THE UPDATE BUTTON IS CLICKED!!!!
//        
//        if currentCell.updateBtn.hidden == false {
//            valuetoPass = currentCell.favorTitle.text
//            valuetoPass_desc = currentCell.descriptionText.text
//            postKey = currentCell.post.postKey
//            
//            
//            performSegueWithIdentifier("seguetoVC", sender: self)
//        }
//        
//        if currentCell.bidBtn.hidden == false {
//            bidInt = currentCell.post.bids
//            postKey = currentCell.post.postKey
//            passUsername = currentCell.post.username
//            
//            performSegueWithIdentifier("seguetoBidVC", sender: self)
//        }
    
    }
    



