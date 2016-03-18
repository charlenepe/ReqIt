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
    
    var postKey: String!
    var favors = [Offer]()
    
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
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favors.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let favor = favors[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("acceptCell") as? OfferAcceptCell {
            var img: UIImage?                        
            
            cell.configureCell(favor, img: img)
            
            return cell
        } else {
            return OfferAcceptCell()
        }
        
    }
}

