//
//  UpdateVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/6/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class PostUpdateVC: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    

    var post: Post? //this will be initialize from the destinationSegue
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {

        if let post = self.post {
            txtTitle.text = post.title
            txtDescription.text = post.description
        }
    }
    
    @IBAction func updatePost(sender: AnyObject){
        
        if let title = txtTitle.text where !title.isEmpty, let description = txtDescription.text where !description.isEmpty {
            
            let postData:[String: AnyObject] = [
                "description": description,
                "title": title,
                "updatedAt": NSDate().timeIntervalSince1970
            ]

            DataService.ds.REF_POSTS.childByAppendingPath(post?.postKey).updateChildValues(postData)
            
            let alert = Utils.showAlert("Favor Request", msg: "Your favor request has been successfully updated")
            
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
