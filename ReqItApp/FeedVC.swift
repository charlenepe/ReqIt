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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var valuetoPass: String!
    var valuetoPass_desc: String!
    var postKey: String!
    var bidInt: Int!
    var passUsername: String!
    
    
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
            img = FeedVC.imageCache.objectForKey(url) as? UIImage
            }
//            
            cell.accessoryType = .DetailDisclosureButton
    

       
            cell.configureCell(post,img:img)
            cell.showBtns(post)
            
            return cell
        } else {
            return PostCell()
        }
        

    }
    
 
    
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath){
        

        // Get Cell Label
//        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! PostCell
        
    /// Right now, you have to click the whole cell to be able to pass the data to UpdateVC :| SHOULD ONLY BE TRIGGERED WHEN THE UPDATE BUTTON IS CLICKED!!!!
        
        if currentCell.updateBtn.hidden == false {
            valuetoPass = currentCell.favorTitle.text
            valuetoPass_desc = currentCell.descriptionText.text
            postKey = currentCell.post.postKey
           
            
            performSegueWithIdentifier("seguetoVC", sender: self)
        }
        
        if currentCell.bidBtn.hidden == false {
              bidInt = currentCell.post.bids
              postKey = currentCell.post.postKey
              passUsername = currentCell.post.username
            
            performSegueWithIdentifier("seguetoBidVC", sender: self)
        }
        
    }
    
// 
//    func buttonselect(sender:UIButton) {
//    
//        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell! {
//
//        let touchPoint = sender.convertPoint(CGPoint.zero, toView:tableView)
//        let indexPath = tableView!.indexPathForRowAtPoint(touchPoint)
//        let currentCell = tableView!.cellForRowAtIndexPath(indexPath!) as! PostCell!
//    
//        
//        if currentCell.updateBtn.hidden == false {
//            
//            valuetoPass = currentCell.favorTitle.text
//            valuetoPass_desc = currentCell.descriptionText.text
//            postKey = currentCell.post!.postKey
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
//
//        
//        // then countiue your code here
//      }
//    }
////
//    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if segue.identifier == "seguetoVC" {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! UpdateVC
            // your new view controller should have property that will store passed value
            viewController.toPassDesc = valuetoPass_desc
            viewController.toPassTitle = valuetoPass
            viewController.postKey = postKey

        }
        
        if segue.identifier == "seguetoBidVC" {
            
            
            // initialize new view controller and cast it as your view controller
            let bidviewController = segue.destinationViewController as! BidVC
            // your new view controller should have property that will store passed value
            bidviewController.postKey = postKey
            bidviewController.bidInt = bidInt
            bidviewController.passUsername = passUsername
        }

        
        
    }
    
    
//    func tableView(tableView: UITableView, acessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        let post = posts[indexPath.row]
//        print(post.title)
//        performSegueWithIdentifier("seguetoVC", sender: self)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "seguetoVC" {
//            let viewController = segue.destinationViewController as! UpdateVC
//            if let post = sender as? Post {
//                viewController.toPassTitle = post.title
//                viewController.toPassDesc = post.postDescription
//            }
//        }
//    }
    
  

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//        
//        let post = posts[indexPath.row]
//        
//        valuetoPass = post.title
//        valuetoPass_desc = post.postDescription
//        
//        performSegueWithIdentifier("seguetoVC", sender: post)
//        
//    }
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let viewController = segue.destinationViewController as! UpdateVC
//    
//        // Prepare the destination view controller with the selected name
//        viewController
//            .prepareForPost(
//              posts[tableView.indexPath.row!])
//
//    }
//    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "seguetoVC" {
//            let viewController = segue.destinationViewController as! UpdateVC
//            let post = sender as? Post
//            viewController.toPassTitle = post!.title
//            viewController.toPassDesc = post!.postDescription
//        }
//    }
    
//    
    
    }




    
    
    
    
    
    
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // 1
//            var reference = Firebase (url:"https://reqit.firebaseio.com/posts981D4B22-0CC9-4D64-9DAA-573EABC225D3")
//            var reference2 = Firebase (url:"https://reqit.firebaseio.com/\(uid)/posts/981D4B22-0CC9-4D64-9DAA-573EABC225D3")
//            reference.removeValue()
//            reference2.removeValue()
//
//            //delete the postkey
//            // 
//            
//            
//        }

    










    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


