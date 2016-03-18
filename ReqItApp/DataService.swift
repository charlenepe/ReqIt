//
//  DataService.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/2/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()

    
    private var _REF_BASE = Firebase(url: URL_BASE)
    private var _REF_POSTS = Firebase(url: URL_POSTS)
    private var _REF_USERS = Firebase(url: URL_USERS)
    private var _REF_OFFERS = Firebase(url: URL_OFFERS)
    
    var uid: String {
        
        get {
            if let id = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as? String {
                return id
            } else {
                return ""
            }
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: KEY_UID)
        }
    }
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }

    var REF_OFFERS: Firebase {
        return _REF_OFFERS
    }
    
    var REF_CURRENT_USER: Firebase {
        return REF_USERS.childByAppendingPath(uid)
    }
    
    func createFirebaseUser(uid: String, user: Dictionary <String, String>){
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
        
}
