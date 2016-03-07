//
//  FeedVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            
            cell.configureCell(post,img:img)
            cell.showBtns(post)
            
            return cell
        } else {
            return PostCell()
        }
        

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
    }
    


    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


