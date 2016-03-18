//
//  MaterialImageView.swift
//  ReqItApp
//
//  Created by Jitendra Gaur on 18/03/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit

class MaterialImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor.darkGrayColor().CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1).CGColor
    }

}
