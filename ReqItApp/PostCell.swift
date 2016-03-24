//
//  PostCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProfile: MaterialImageView!

    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnUnBid: MaterialButton!
    @IBOutlet weak var btnBid: MaterialButton!
    
    @IBOutlet weak var btnDelete: MaterialButton!
    @IBOutlet weak var btnUpdate: MaterialButton!
    
    var request: Request?
    var singPlural: String!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //imgProfile.clipsToBounds = true
    }
    
    func configureCell(post: Post, img: UIImage?){        
        txtDescription.text = post.description
        lblTitle.text = post.title
        lblUserName.text = post.username
        
        singPlural = (post.pending == 1) ? "offer" : "offers"
        
        lblOffer.text = "\(post.pending) \(singPlural)"
        //        imgProfile.image =
        
        if post.username == DataService.ds.uid {
            btnBid.hidden = true
            btnUnBid.hidden = true

            btnUpdate.hidden = false
            btnDelete.hidden = false
        } else {
            btnBid.hidden = false
            btnUnBid.hidden = false
            
            //else { //this is the default:
//            self.btnBid.enabled = true
//            self.btnUnBid.enabled = false
        

        
      DataService.ds.REF_OFFERS.queryOrderedByChild("postKey").queryEqualToValue(post.postKey).observeEventType(.ChildAdded, withBlock:{ snapshot in
        
                if let username = snapshot.value["username"] as? String {
                    if username == DataService.ds.uid {
                       self.btnBid.enabled = false
                       self.btnUnBid.enabled = true
                    }
                }
      })
            
            
            btnUpdate.hidden = true
            btnDelete.hidden = true
        }
    }
    
}




