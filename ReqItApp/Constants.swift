

import Foundation
import UIKit
import Firebase

let SHADOW_COLOR:CGFloat = 157.0 / 255.0

//Keys
let KEY_UID = "uid"


//Segues

let SEGUE_LOGGED_IN = "loggedIn"

//Status codes
let STATUS_ACCOUNT_NONEXIST = -8

//userloginstuff


let reff = Firebase(url: "https://reqit.firebaseio.com")
let uid = reff.authData.uid
let ref = Firebase(url: "https://reqit.firebaseio.com/posts")
let userpost = Firebase(url: "https://reqit.firebaseio.com/users/\(uid)/posts")





