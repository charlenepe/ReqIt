//
//  AddingVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/4/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class AddingVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var favorTxt: UITextField!
    @IBOutlet weak var descTxt: UITextView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favorTxt.delegate = self
        self.descTxt.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addNewPost(sender:UIButton!){
       
       let reff = Firebase(url: "https://reqit.firebaseio.com")
        let uid = reff.authData.uid

        let uuid = NSUUID().UUIDString

        
    
        let ref = Firebase(url: "https://reqit.firebaseio.com/posts")
        let userpost = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts")
  

        
        var desc = descTxt.text
        var favtxt = favorTxt.text
        
        
        
        if favtxt != "" && desc != nil, let existdesc = desc, let existfavtxt = favtxt {
            

            var favor = ["bids": 0, "description": "\(desc)", "imgURL": "http://cityseed.org/wp-content/....", "title": "\(favtxt!)", "username":"\(uid)"]
        
        
        //access the userid!!!
        ref.childByAppendingPath("\(uuid)").setValue(favor)
        userpost.childByAppendingPath("\(uuid)").setValue(favor)
        
        showAddedAlert("Favor Request", msg: "Your favor request has been successfully posted")
        favorTxt.text = ""
        descTxt.text = ""
        
        } else {
             showAddedAlert("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.")
        }

        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func showAddedAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//
//import UIKit
//import Firebase
//
//
//
//
//class AddingVC: UIViewController {
//    
//    @IBOutlet weak var postBtn: UIButton!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    
//    
//    @IBAction func addNewPost(sender:UIButton!){
//        
//        let ref = Firebase(url: "https://reqit.firebaseio.com/users")
//        
//        var alanisawesome = ["full_name": "Alan Turing", "date_of_birth": "June 23, 1912"]
//        var gracehop = ["full_name": "Grace Hopper", "date_of_birth": "December 9, 1906"]
//        
//        var usersRef = ref.childByAppendingPath("users")
//        
//        var users = ["alanisawesome": alanisawesome, "gracehop": gracehop]
//        usersRef.setValue(users)
//
//
//
////        DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: {error, authData in
////
////            if error != nil {
////                print("Login failed. \(error)")
////            } else {
////                print("Logged in! \(authData)")
////                //create a Firebase post
////
////                let user = ["provider": authData.provider!, "blah": "test"]
////                DataService.ds.createFirebaseUser(authData.uid, user: user)
////
////                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
////                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
////
//
