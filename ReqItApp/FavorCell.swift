//
//  FavorCellTableViewCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/13/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class FavorCell: UITableViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var favorDesc: UITextView!
    let uid = reff.authData.uid
    
    //change this to favor next time
    
    var post: Post!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //change this to favor if this is running

    
    func hidePost(post: Post){
        
        self.post = post
        
        if post.username != uid {
            mainImg.hidden = true
            mainLbl.hidden = true
            favorDesc.hidden = true
            self.hidden = true
            //
        
          }
        
    }
    
    

    
    func configureCell(post: Post){
        mainLbl.text = post.title
        favorDesc.text = post.postDescription
        
    }

   
}
