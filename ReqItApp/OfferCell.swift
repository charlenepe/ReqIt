//
//  OfferCell.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/8/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit

class OfferCell: UITableViewCell {
    
    @IBOutlet weak var approveBtn: UIButton!

    var offer: Offer!
    let uid = reff.authData.uid

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
