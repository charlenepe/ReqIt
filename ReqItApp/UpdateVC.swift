//
//  UpdateVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/6/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class UpdateVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var favorTxt: UITextField!
    @IBOutlet weak var descTxt: UITextView!
    var timer = NSTimer()
    var toPassTitle:String!
    var toPassDesc:String!
    var postKey: String!
    var post: Post!
    let uid = reff.authData.uid

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.favorTxt.delegate = self
        self.descTxt.delegate = self
        favorTxt.text = toPassTitle
        descTxt.text = toPassDesc

//        descTxt.text = toPassDesc



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func updateActn(sender: AnyObject) {
            updatethis(postKey)
            favorTxt.text = ""
            descTxt.text = ""
        
    }
    
    func showUpdatedAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func segue(){

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("tabVC") as! UITabBarController
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
    }
    
    func updatethis(postKey: String){
        
        
        let uid = reff.authData.uid
        let path = Firebase(url: "https://reqit.firebaseio.com/posts/\(postKey)")
        let path2 = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts/\(postKey)")
        
        let favortxt = favorTxt.text
        let desctxt = descTxt.text
        
        if favortxt != "" && desctxt != "" && favortxt != nil && desctxt != nil {
        
            let updatedfavor = ["title": favorTxt.text, "description": descTxt.text]
        
            path.updateChildValues(updatedfavor)
            path2.updateChildValues(updatedfavor)
            showUpdatedAlert("Favor Request", msg: "Your favor request has been successfully updated")
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "segue", userInfo: nil, repeats: true)

        } else {
            showUpdatedAlert("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.")
        }
        
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    



}
