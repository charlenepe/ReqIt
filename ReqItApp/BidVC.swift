//
//  BidVC.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/7/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import Firebase

class BidVC: UIViewController {
    
    var bidCount: String!
    var bidInt: Int!
    var timer = NSTimer()
    var postKey: String!
    
    
    @IBOutlet weak var secondFvrdescTxt: UITextView!
    @IBOutlet weak var secondFvr: UITextField!
    
    @IBOutlet weak var bidBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.bidInt = Int(bidCount)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func bidAction(sender: UIButton){

        bidAdd()
     
        
    }
    
    //method to connect number of bids to BidVC
    func bidAdd(){
        //append to bids
        if secondFvr.text != nil && secondFvrdescTxt.text != nil && secondFvr.text != "" && secondFvrdescTxt.text != "" {
            showBidAlert("Bid", msg: "Bid has been recorded")
//            bidInt = bidInt + 1
            
            
            
            let reff = Firebase(url: "https://reqit.firebaseio.com")
            let uid = reff.authData.uid
            var biddesc = secondFvrdescTxt.text
            var bidtxt = secondFvr.text
            let ref = Firebase(url: "https://reqit.firebaseio.com/posts/\(postKey)/offers")
            let bidpost = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts/\(postKey)/offers")
            let bidid = NSUUID().UUIDString
            
            var bid = ["description": "\(biddesc)", "imgURL": "http://cityseed.org/wp-content/....", "title": "\(bidtxt!)", "username":"\(uid)"]
            
            
            //access the userid!!!
            ref.childByAppendingPath("\(bidid)").setValue(bid)
            bidpost.childByAppendingPath("\(bidid)").setValue(bid)
            //append to "../bids"
            
            showBidAlert("Bid Request", msg: "Your offer has been posted")
            
         
            //this is where we are going to alter the # of bids. We are also going to add a  new bid in the JSON Firebase tree!!!
            //remember to change the code to reflect +1 bids
            secondFvr.text = ""
            secondFvrdescTxt.text = ""
            
            
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "segue", userInfo: nil, repeats: true)
            
        
            
        } else {
            showBidAlert("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.")
            
        }
    }
    
    
    
    func showBidAlert(title: String, msg: String){
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
    
//    func updatethis(postKey: String){
//        let path = Firebase(url: "https://reqit.firebaseio.com/posts/\(postKey)")
//        let path2 = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts/\(postKey)")
//        
//        let favortxt = favorTxt.text
//        let desctxt = descTxt.text
//        
//        if favortxt != "" && desctxt != "" && favortxt != nil && desctxt != nil {
//            
//            let updatedfavor = ["title": favorTxt.text, "description": descTxt.text]
//            
//            path.updateChildValues(updatedfavor)
//            path2.updateChildValues(updatedfavor)
//            showUpdatedAlert("Favor Request", msg: "Your favor request has been successfully updated")
//            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "segue", userInfo: nil, repeats: true)
//            
//        } else {
//            showUpdatedAlert("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.")
//        }

    

}
