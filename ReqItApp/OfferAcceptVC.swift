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
             self.favors.sortInPlace{ $0.createdAt > $1.createdAt}
            self.tableView.reloadData()
        })
    }



    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favors.count
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
}

