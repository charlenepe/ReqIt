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

class AcceptCell: UITableViewCell {
    
    @IBOutlet weak var acceptImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    
    var favor: Offer!
    //this is the cell where the user can approve bids! :D

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(favor: Offer){
        usernameLbl.text = favor.username
        desTxt.text = favor.description
        titleLbl.text = favor.title
    }

}
