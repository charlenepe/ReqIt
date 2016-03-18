//
//  AcceptCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/17/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class OfferAcceptCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: MaterialImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var request: Request?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(post: Offer, img: UIImage?){
        txtDescription.text = post.description
        lblTitle.text = post.title
        lblUserName.text = post.username
        //        imgProfile.image =
    }

}
