//
//  UpdateVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/6/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class OfferAddVC: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    
    var post: Post? //this will be initialize from the destinationSegue
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func addOffer(sender: AnyObject){
        
        if let title = txtTitle.text where !title.isEmpty, let description = txtDescription.text where !description.isEmpty {
            
            let postData  = (post)!
            
            let offerData:[String: AnyObject] = [
                "description": description,
                "title": title,
                "postKey": postData.postKey,
                "username": DataService.ds.uid,
                "accepted": false,
                "createdAt": NSDate().timeIntervalSince1970
            ]
            
            DataService.ds.REF_OFFERS.childByAutoId().setValue(offerData)
            
            //also add on users tree for reffrence so we can easly check
            //users/currentuser/offers/postKey/true
            
            DataService.ds.REF_CURRENT_USER.childByAppendingPath("offers").childByAppendingPath(postData.postKey).setValue(true)
            
            //update the pendingCount 
            postData.updatePending(true)            

            txtDescription.text = ""
            txtTitle.text = ""
            
            let alert = Utils.showAlert("Bid Request", msg: "Your Bid request has been successfully submitted")
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            alert.addAction(action)
            
            presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            Utils.showAlertWithoutHandler("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.", view: self)
        }
    }
    
    
    
    
    
}
