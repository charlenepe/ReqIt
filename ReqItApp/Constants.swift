

import Foundation
import UIKit
import Firebase

let SHADOW_COLOR:CGFloat = 157.0 / 255.0

//Firebase URLS
let URL_BASE = "https://testbid.firebaseio.com"
let URL_POSTS = "\(URL_BASE)/posts"
let URL_USERS = "\(URL_BASE)/users"
let URL_OFFERS = "\(URL_BASE)/offers"


//Keys
let KEY_UID = "uid"


//Segues
let SEGUE_LOGGED_IN = "loggedIn"
let SEGUE_TO_POST_UPDATE = "segueToPostUpdate"
let SEGUE_TO_OFFER_ACCEPT = "segueToOfferAccept"
let SEGUE_TO_OFFER_ADD = "segueToOfferAdd"

//Status codes
let STATUS_ACCOUNT_NONEXIST = -8




