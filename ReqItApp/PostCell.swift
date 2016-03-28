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
    
    @IBOutlet weak var pressedUnBid: UIButton!
    
    var request: Request?
    var singPlural: String!
    var likeRef: Firebase!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: "unbidTapped:")
        tap.numberOfTapsRequired = 1
        pressedUnBid.addGestureRecognizer(tap)
        pressedUnBid.userInteractionEnabled = true
        self.btnBid.addGestureRecognizer(tap)
        self.btnBid.userInteractionEnabled = true
//        self.btnUnBid.addGestureRecognizer(tap)
//        self.btnUnBid.userInteractionEnabled = true

        
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
//        lblOffer.hidden = true
        
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
            
//back self.btnUnBid.enabled = false
 
//                
//                DataService.ds.REF_OFFERS.queryOrderedByChild("postKey").queryEqualToValue(post.postKey).observeEventType(.ChildAdded, withBlock:{ snapshot in
//                    
//                    if let username =  snapshot.value["username"] as? String {
//                        if username == DataService.ds.uid {
//                            self.btnUnBid.enabled = true
//                        
//                        }
//                    } //
////                    }
//                    })
//
//                self.onVoteButton()
// 
//        
//        
//      })
            
            
            likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("offers").childByAppendingPath(post.postKey)
            
            likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                if let doesNotExist = snapshot.value  as? NSNull {//nsnull: no data in .value---> firebase value
                    //this means that we have not made a bid
                    self.btnBid.enabled = true
                    self.btnUnBid.enabled = false
                    
                } else {
                    self.btnBid.enabled = false
                    self.btnUnBid.enabled = true
                    
                }
                
//                self.btnUnBid.enabled = true
//                self.btnBid.enabled = false
            })
        
  
            btnUpdate.hidden = true
            btnDelete.hidden = true
        }
    }
    

    func unbidTapped(sender: UITapGestureRecognizer){
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value  as? NSNull {
                self.btnBid.enabled = true
                self.btnUnBid.enabled = false
            } else {
                self.btnBid.enabled = false
                self.btnUnBid.enabled = true
            
            }
 
        
    })
    
}

}









