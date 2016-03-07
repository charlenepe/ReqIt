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

    
    
    @IBAction func updateActn(sender: AnyObject) {
        
///need to put a reference linking the table view cell to the update fields
        
        
        var desc = descTxt.text
        var favtxt = favorTxt.text
        
        
        
        if favtxt != "" && desc != nil, let existdesc = desc, let existfavtxt = favtxt {
            
            
            var favor = ["bids": 0, "description": "\(desc)", "imgURL": "http://cityseed.org/wp-content/....", "title": "\(favtxt!)", "username":"\(uid)"]
            
            
            //access the userid!!!
       
//            usersRef.updateChildValues([
//                "alanisawesome/nickname": "Alan The Machine",
//                "gracehop/nickname": "Amazing Grace"
//                ])
            
            
            showUpdatedAlert("Favor Request", msg: "Your favor request has been successfully updated")
            favorTxt.text = ""
            descTxt.text = ""
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "segue", userInfo: nil, repeats: true)
            
        } else {
            showUpdatedAlert("Error", msg: "Please recheck fields. Cannot leave favor title and description blank.")
        }

        
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
