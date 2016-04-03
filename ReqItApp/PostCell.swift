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
    }
    
    
    //
    //    func onVoteButton() {
    //
    //        if self.btnUnBid.enabled == true{
    //            self.btnBid.enabled = false
    //
    //        } else {
    //            self.btnBid.enabled = true
    //        }
    //
    //    }
    //
    
    func configureCell(post: Post, img: UIImage?){
        txtDescription.text = post.description
        lblTitle.text = post.title
        lblUserName.text = post.username
        //lblOffer.hidden = true
        
        //TODO: Change post.pending to post.bids
        singPlural = (post.pending == 1) ? "offer" : "offers"
        
        lblOffer.text = "\(post.pending) \(singPlural)"
        //imgProfile.image =
        
        
        
        if post.username == DataService.ds.uid {
            btnBid.hidden = true
            btnUnBid.hidden = true
            
            btnUpdate.hidden = false
            btnDelete.hidden = false
            
        } else {
            btnBid.hidden = false
            btnUnBid.hidden = false
            
            btnUpdate.hidden = true
            btnDelete.hidden = true
            
            
            //Check if user already clicked on BidButton
            
            let likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("offers").childByAppendingPath(post.postKey)
            

            likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                if snapshot.value is NSNull {
                    //nsnull: no data in .value---> firebase value
                    //this means that we have not made a bid
                    
                    self.btnBid.enabled = true
                    self.btnBid.alpha = 1
                    
                    self.btnUnBid.enabled = false
                    self.btnUnBid.alpha = 0.3
                } else {
                    self.btnBid.alpha = 0.3
                    self.btnBid.enabled = false
                    
                    self.btnUnBid.enabled = true
                    self.btnUnBid.alpha = 1
                    
                }
            })
            
        }
    }
    
}









