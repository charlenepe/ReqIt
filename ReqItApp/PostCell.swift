//
//  PostCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var postsLbl: UILabel!
    

    
    var post: Post!



    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
    }

    func configureCell(post: Post){
        self.post = post
        self.descriptionText.text = post.postDescription
        self.postsLbl.text = "\(post.bids) offers"
        }
    }
    
    


