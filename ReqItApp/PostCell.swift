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
    

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var postsLbl: UILabel!
    
    @IBOutlet weak var unbidBtn: MaterialButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var bidBtn: MaterialButton!

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var favorTitle: UILabel!
    
    var post: Post!
    var request: Request?
    let uid = reff.authData.uid




    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
    }

    func configureCell(post: Post, img: UIImage?){
        self.post = post
        self.descriptionText.text = post.postDescription
        self.postsLbl.text = "\(post.bids) offers"
        self.favorTitle.text = post.title
        self.userLbl.text = post.username
              }
    
    func showBtns(post: Post){
        
       
        self.post! = post

        if post.username == uid {
            updateBtn.hidden = false
            deleteBtn.hidden = false
            bidBtn.hidden = true
            unbidBtn.hidden = true
        } else {
            updateBtn.hidden = true
            deleteBtn.hidden = true
            bidBtn.hidden = false
            unbidBtn.hidden = false
        }
    
    
    }
    
    @IBAction func deleteAction(sender: UIButton){
        
        deletethis(post)
        
    }
    
    func deletethis(post: Post){
        let path = Firebase(url: "https://reqit.firebaseio.com/posts/\(post.postKey)")
        let path2 = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts/\(post.postKey)")
        
        path.removeValue()
        path2.removeValue()
    }
    
    @IBAction func updateAction(sender: UIButton){
        clicked(sender)
    }
    
  
    func clicked(sender: UIButton)-> Bool{
        return true
        
    }

    
    }

    


