//
//  AddingVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/4/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class PostAddVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewPost(sender:UIButton!){
        
        if let title = txtTitle.text where !title.isEmpty, let description = txtDescription.text where !description.isEmpty {
            
            let postData = [
                "bids": 0,
                "pending":0,
                "description": description,
                "imgURL": "http://cityseed.org/wp-content/....",
                "title": title,
                "username": DataService.ds.uid,
                "createdAt": NSDate().timeIntervalSince1970,
                "updatedAt": NSDate().timeIntervalSince1970
            ]
            
            
            DataService.ds.REF_POSTS.childByAutoId().setValue(postData)
            
            Utils.showAlertWithoutHandler("Favor Request", msg: "Your favor request has been successfully posted", view: self)
            
            txtDescription.text = ""
            txtTitle.text = ""
            
            
        } else {
            Utils.showAlertWithoutHandler("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.", view: self)
        }
        
    }
    
    

    
}

