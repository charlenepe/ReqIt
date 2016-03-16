//
//  FavorVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/13/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class FavorVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    let uid = reff.authData.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

//        
//        let ref = Firebase(url:"http://reqit.firebase.com/users/\(uid)/posts")
//        // Attach a closure to read the data at our posts reference
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
     

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
//
            self.tableView.reloadData()
        })

    

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("favorCell") as? FavorCell {
            
            //if let data = NSData(contentsofURL: url){
                //let img= UIImage(data: data)
        //}
            
        
              cell.configureCell(post)
              cell.hidePost(post)
              return cell
        } else {
            return FavorCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

  }
