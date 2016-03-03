//
//  ViewController.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/2/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbBtnPressed(sender: UIButton){
        let facebookLogin = FBSDKLoginManager()
    
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: nil) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError:NSError!) -> Void in
        
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookLogin)")
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with Facebook. \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: {error, authData in
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                    
                })
                
        
            
        }

        
    }

}
}


