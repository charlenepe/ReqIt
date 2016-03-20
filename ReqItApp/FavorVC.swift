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
    
    var postKey: String!
    var postTitle: String!
    var mypost = Firebase(url: "https://reqit.firebase.com/offers")
    
    
    @IBOutlet weak var feed: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var unhiddenposts = [Post]()
    let uid = reff.authData.uid
    var favors = [Offer]()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("Dumaan")
        

//        
//        let ref = Firebase(url:"http://reqit.firebase.com/users/\(uid)/posts")
//        // Attach a closure to read the data at our posts reference
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
     
        print("boooooo")

        mypost.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
            self.posts = []
            self.unhiddenposts = []
            self.favors = []
            
            print("OMG")
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                
                
                for snap in snapshots {
//                    print("SNAP: \(snap)")
                    if let favdic = snap.value as? Dictionary <String, String>{
                        let key = snap.key
                        let fav = Offer(bidKey: key, title: favdic["title"], bidDescription: favdic["bidDiscription"])
                        
                        
                        self.favors.append(fav)

                    }
                }
            }
//
            self.tableView.reloadData()
        })

    

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let favor = favors[indexPath.row]

        
        if let cell = tableView.dequeueReusableCellWithIdentifier("favorCell") as? FavorCell {
            
            //if let data = NSData(contentsofURL: url){
                //let img= UIImage(data: data)
        //}
             cell.accessoryType = .DetailDisclosureButton

              cell.configureCell(favor)
//              cell.hidePost(post)
              return cell
        } else {
            return FavorCell()
        }
    }
    
     func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath){
        
                let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! FavorCell
        
        
        postKey = currentCell.postKey.text
        performSegueWithIdentifier("seguetoAccept", sender: self)
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let viewControllerAccept = segue.destinationViewController as! AcceptVC
        viewControllerAccept.postKey = postKey
        
   //passing the postKey to AcceptVC's postKey :P
        
    }
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favors.count
    }

  }
