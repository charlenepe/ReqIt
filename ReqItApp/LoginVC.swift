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



class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !DataService.ds.uid.isEmpty {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
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
                        //create a Firebase user
                        
                        let user = ["provider": authData.provider!, "posts" : ""]
                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                        DataService.ds.uid = authData.uid
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })
                
            }
        }
    }
    
    @IBAction func attemptLogin(sender: UIButton!){
        if let email = txtEmail.text where email != "", let pwd = txtPassword.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error.code)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result  in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account")
                            } else {
                                
                                    DataService.ds.uid = result[KEY_UID] as! String
                                
                                DataService.ds.REF_BASE.authUser(email, password:
                                    pwd, withCompletionBlock: {
                                        err, authData in
                                        
                                        let user = ["provider": authData.provider!]
                                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                                        
                                })
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                            
                        })
                    } else {
                        self.showErrorAlert("Could not log in", msg: "Please check username or password")
                    }
                    
                } else {
                    DataService.ds.uid = authData.uid
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
            })
            
            
        } else {
            showErrorAlert("Email and password", msg: "You must enter an email and a password")
        }
    }
    
    func showErrorAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



