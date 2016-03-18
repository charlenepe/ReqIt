//
//  FavorCellTableViewCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/13/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post){
        lblTitle.text = post.title
        lblOffer.text = "\(post.pending) pending"
        
        let date = NSDate(timeIntervalSince1970: post.createdAt)
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        
        lblCreated.text = formatter.stringFromDate(date)
        
        txtDescription.text = post.description
        
        //imgMain.image = post.imgURL
    }   
}
