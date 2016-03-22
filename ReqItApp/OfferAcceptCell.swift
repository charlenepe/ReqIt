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
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var reject: MaterialButton!
    @IBOutlet weak var accept: MaterialButton!
    
    var request: Request?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(favor: Offer, img: UIImage?){
        txtDescription.text = favor.description
        lblTitle.text = favor.title
        lblUserName.text = favor.username

        
        
        //        imgProfile.image =
    }
    
    
    @IBAction func acceptActn(sender: AnyObject) {
        
        
    }
    
    
    

}
